import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from 'src/auth/model/user.entity';
import { Feed } from '../model/feed.entity';
import { FeedDTO } from '../model/feed.dto';
import { FeedRepository } from '../repository/feed.repository';
import { DeleteResult, IsNull, LessThan, Like, Not, UpdateResult } from 'typeorm';
import { FeedUpdateDTO } from '../model/feed-update.dto';
import { FeedCategoryRepository } from '../repository/feed-category.repository';
import { FeedCategory } from '../model/feed-category.entity';

@Injectable()
export class FeedService {

    constructor(
        @InjectRepository(FeedRepository)
        private feedRepository : FeedRepository,
        @InjectRepository(FeedCategoryRepository)
        private feedCategoryRepository : FeedCategoryRepository,
    ){}

    getMyFeed(user:User){
        return this.feedRepository.find({
            loadRelationIds:{
                relations:['comments','likeUsers']
            },
            where:{writer:user}
        })
    }

    findFeeds(take:number,skip:number,selectedCategory?:string):Promise<Feed[]>{
        return selectedCategory?this.feedRepository.findAndCount({
            take,skip,
            relations:['writer','category'],
            loadRelationIds:{
                relations:['comments','likeUsers']
            },
            where:{
                category:{categoryTitle:selectedCategory}
            }
        }).then(([feed])=>{
            return feed;
        }):this.feedRepository.findAndCount({
            take,skip,
            relations:['writer','category'],
            loadRelationIds:{
                relations:['comments','likeUsers']
            },
        }).then(([feeds])=>{
            if(feeds.length === 0){
                throw new NotFoundException(`No feeds`)
            }
            return feeds;
        })
    }

    findByKeyword(take:number,skip:number,keyword?:string,cate?:string):Promise<Feed[]>{
        const whereContidtion = cate?{
            category:{categoryTitle:cate},
            description: keyword?Like(`%${keyword}%`): Not(IsNull())
        }:{
            description:  keyword?Like(`%${keyword}%`): Not(IsNull())
        }
        return this.feedRepository.findAndCount({
            take,skip,
            relations:['writer','category'],
            loadRelationIds:{
                relations:['comments','likeUsers']
            },
            
            where:whereContidtion
        }).then(([feeds])=>{
            if(feeds.length === 0){
                throw new NotFoundException(`No feeds`)
            }
            return feeds;
        })
    }

    getHotFeed(){
        return this.feedRepository.createQueryBuilder('feed')
        .loadRelationCountAndMap("COALESCE('feed.commentCount',0)", 'feed.comments')
        // .where(" 'feed.commentCount' > :num ",{num:2})
        .where(` 'feed.commentCount' > 2 `)
        .getMany()
    }

    findFeedById(id:number):Promise<Feed>{
        return this.feedRepository.findOneOrFail({id},{
            relations:['writer','comments','comments.writer','category','likeUsers','likeUsers.user'],
        });
    }

    writeFeed(user:User, feedDTO:FeedDTO):Promise<Feed>{
        return this.feedCategoryRepository.findOneOrFail({categoryTitle:feedDTO.category})
        .then((category:FeedCategory)=>{
            return this.feedRepository.writeFeed(user,feedDTO,category)
        })
    }

    async updateFeed(id:number,updateFeedDTO:FeedUpdateDTO):Promise<UpdateResult>{

        const feed:Feed = await this.feedRepository.findOneOrFail(id)
        const {
            addedImagePath,
            removedImagePath,
            description
        }  = updateFeedDTO
        feed.description = description? description:feed.description;
        feed.imagePath = removedImagePath?feed.imagePath.filter((imagePath)=>!removedImagePath.includes(imagePath)):feed.imagePath;
        feed.imagePath = feed.imagePath.concat(addedImagePath)
        
        return this.feedRepository.update(id,feed).then((result)=>{
            // remove image in removedImagePath
            return result
        });
    }

    async deleteFeed(id:number):Promise<Feed>{
        const feed = await this.feedRepository.findOneOrFail({id},{
            relations:['comments']
        })
        return this.feedRepository.softRemove(feed);
    }
    
}
