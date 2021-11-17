import { EntityRepository, Repository } from "typeorm";
import { LikeFeed } from "../model/like-feed.entity";

@EntityRepository(LikeFeed)
export class LikeFeedRepository extends Repository<LikeFeed>{
    
}