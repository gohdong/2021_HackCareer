import { EntityRepository, Repository, UpdateResult } from "typeorm";


@EntityRepository(Comment)
export class CommentRepository extends Repository<Comment>{

    
}