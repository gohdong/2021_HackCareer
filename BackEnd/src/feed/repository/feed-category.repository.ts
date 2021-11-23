import { EntityRepository, Repository } from "typeorm";
import { FeedCategory } from "../model/feed-category.entity";


@EntityRepository(FeedCategory)
export class FeedCategoryRepository extends Repository<FeedCategory>{
    
}