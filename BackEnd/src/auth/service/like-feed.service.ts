import { ConflictException, Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { Feed } from "src/feed/model/feed.entity";
import { FeedRepository } from "src/feed/repository/feed.repository";
import { LikeFeed } from "../model/like-feed.entity";
import { User } from "../model/user.entity";
import { LikeFeedRepository } from "../repository/like-feed.repository";

@Injectable()
export class LikeFeedService {
    constructor(
        @InjectRepository(LikeFeedRepository)
        private likeFeedRepository : LikeFeedRepository,
        @InjectRepository(FeedRepository)
        private feedRepository : FeedRepository
    ){}

    async createLike(user:User,feedId:number):Promise<LikeFeed>{
        try {
            return this.feedRepository.findOneOrFail(feedId,{
            }).then((feed:Feed)=>{
                const likeFeed :LikeFeed = this.likeFeedRepository.create({user,feed})
                return this.likeFeedRepository.save(likeFeed);
            });
        } catch (error) {
            throw new ConflictException(`Already Liked`)
            
        }
    }

    

    
}