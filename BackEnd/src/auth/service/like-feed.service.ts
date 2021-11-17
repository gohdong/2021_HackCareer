import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
// import { FeedRepository } from "src/feed/repository/feed.repository";
import { LikeFeedRepository } from "../repository/like-feed.repository";

@Injectable()
export class LikeFeedService {
    constructor(
        @InjectRepository(LikeFeedRepository)
        private userRepository : LikeFeedRepository,
        // @InjectRepository(FeedRepository)
        // private feedRepository : FeedRepository
    ){}

    // create

    

    
}