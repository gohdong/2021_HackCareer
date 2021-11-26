import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from 'src/auth/model/user.entity';
import { CommentRepository } from '../repository/comment.repository';
import { FeedRepository } from '../repository/feed.repository';
import { Comment } from '../model/comment.entity';
import { DeleteResult, UpdateResult } from 'typeorm';
import { Feed } from '../model/feed.entity';

@Injectable()
export class CommentService {
    constructor(
        @InjectRepository(CommentRepository)
        private commentRepository : CommentRepository,
        @InjectRepository(FeedRepository)
        private feedRepository : FeedRepository,
    ){}

    getHotFeed(){
        return this.commentRepository.createQueryBuilder('comment')
        .select('comment.feedId AS feedId')
        .addSelect('COUNT(*)::INTEGER AS commentCount')
        .groupBy('comment.feedId')
        .orderBy('commentCount')
        .limit(30)
        .getRawMany()
    }

    async createComment(user:User,feedId:number,content:string):Promise<Comment>{
        return this.feedRepository.findOneOrFail(feedId).then((feed:Feed)=>{
            return this.commentRepository.createComment(user,feed,content);
        })
    }

    async findCommentById(id:number):Promise<Comment>{
        return this.commentRepository.findOneOrFail(id,{
            relations:['writer']
        });
    }

    async updateComment(feedId:number,commentId:number,content:string):Promise<UpdateResult>{
        await this.feedRepository.findOneOrFail(feedId);
        return this.commentRepository.updateComment(commentId,content)
    }

    async deleteComment(feedId:number,commentId:number,content:string):Promise<DeleteResult>{
        await this.feedRepository.findOneOrFail(feedId);
        return this.commentRepository.softDelete(commentId)
    }

}
