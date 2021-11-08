import { EntityRepository, Repository } from "typeorm";
import { Feed } from "../model/feed.entity";

@EntityRepository(Feed)
export class FeedRepository extends Repository<Feed>{

    
}