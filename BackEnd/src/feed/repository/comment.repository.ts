import { User } from "src/auth/model/user.entity";
import { EntityRepository, Repository, UpdateResult } from "typeorm";
import { Feed } from "../model/feed.entity";
import { Comment } from "../model/comment.entity";
import { NotFoundException } from "@nestjs/common";


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

    async updateComment(id:number,content:string):Promise<UpdateResult>{
        const comment:Comment = await this.findOne(id);
        if(!comment){
            throw new NotFoundException(`Not found comment with id: ${id}`)
        }
        comment.content  = content;
        return this.update(id,comment)
    }
}