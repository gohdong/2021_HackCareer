import { User } from "src/auth/model/user.entity";
import { EntityRepository, Repository, UpdateResult } from "typeorm";
import { Feed } from "../model/feed.entity";
import { Comment } from "../model/comment.entity";


@EntityRepository(Comment)
export class CommentRepository extends Repository<Comment>{

    async createComment(user:User,feed:Feed,content:string):Promise<Comment>{
        const comment:Comment = this.create({
            writer:user,
            feed,
            content
        })
        return await this.save(comment);
    }
}