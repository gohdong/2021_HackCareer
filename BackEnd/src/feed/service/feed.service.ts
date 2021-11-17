import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from 'src/auth/model/user.entity';
import { Feed } from '../model/feed.entity';
import { FeedDTO } from '../model/feed.dto';
import { FeedRepository } from '../repository/feed.repository';
import { DeleteResult, UpdateResult } from 'typeorm';
import { UpdateFeedDTO } from '../model/update-feed.dto';

@Injectable()
export class FeedService {

    constructor(
        @InjectRepository(FeedRepository)
        private feedRepository : FeedRepository,
    ){}

    findFeeds(take:number,skip:number):Promise<Feed[]>{
        return this.feedRepository.findAndCount({
            take,skip,
            relations:['comments']
        }).then(([feeds])=>{
            if(feeds.length == 0){
                throw new NotFoundException(`No Feeds`)
            }
            return <Feed[]>feeds;
        })
    }

    findFeedById(id:number):Promise<Feed>{
        return this.feedRepository.findById(id);
    }

    writeFeed(user:User, feedDTO:FeedDTO):Promise<Feed>{
        return this.feedRepository.writeFeed(user,feedDTO)
    }

    async updateFeed(id:number,updateFeedDTO:UpdateFeedDTO):Promise<UpdateResult>{

        const feed:Feed = await this.feedRepository.findById(id)
        const {
            addedImagePath,
            removedImagePath,
            description
        }  = updateFeedDTO
        feed.description = description? description:feed.description;
        feed.imagePath = removedImagePath?feed.imagePath.filter((imagePath)=>!removedImagePath.includes(imagePath)):feed.imagePath;
        feed.imagePath = feed.imagePath.concat(addedImagePath)
        console.log(feed);
        
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
