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
        return this.feedRepository.findAndCount({take,skip}).then(([feeds])=>{
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

    updateFeed(id:number,feedDTO:FeedDTO):Promise<UpdateResult>{
        return this.feedRepository.updateFeed(id,feedDTO);
    }

    deleteFeed(id:number):Promise<DeleteResult>{
        this.findFeedById(id);
        return this.feedRepository.softDelete(id);
    }
    
}
