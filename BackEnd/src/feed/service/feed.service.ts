import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from 'src/auth/model/user.entity';
import { Feed } from '../model/feed.entity';
import { FeedDTO } from '../model/feed.dto';
import { FeedRepository } from '../repository/feed.repository';
import { DeleteResult, UpdateResult } from 'typeorm';

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

    async updateFeed(id:number,description:string,addedImagePath:string[],removedImagePath:string[]):Promise<UpdateResult>{
        const feed:Feed = await this.feedRepository.findById(id)
        feed.description = description? description:feed.description;
        feed.imagePath = removedImagePath?feed.imagePath.filter((imagePath)=>!removedImagePath.includes(imagePath)):feed.imagePath;
        feed.imagePath = feed.imagePath.concat(addedImagePath)
        console.log(feed);
        
        return this.feedRepository.update(id,feed).then((result)=>{
            // remove image in removedImagePath
            return result
        });
    }

    deleteFeed(id:number):Promise<DeleteResult>{
        this.findFeedById(id);
        return this.feedRepository.softDelete(id);
    }
    
}
