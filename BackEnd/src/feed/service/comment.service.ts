import { ConflictException, Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from 'src/auth/model/user.entity';
import { CommentRepository } from '../repository/comment.repository';
import { FeedRepository } from '../repository/feed.repository';
import { Comment } from '../model/comment.entity';
import { DeleteResult, UpdateResult } from 'typeorm';

@Injectable()
export class CommentService {
    constructor(
        @InjectRepository(CommentRepository)
        private commentRepository : CommentRepository,
        @InjectRepository(FeedRepository)
        private feedRepository : FeedRepository,
    ){}

    async createComment(user:User,feedId:number,content:string):Promise<Comment>{
        const feed = await this.feedRepository.findOne(feedId);
        return this.commentRepository.createComment(user,feed,content);
    }

    async findCommentById(id:number):Promise<Comment>{
        return this.commentRepository.findOne(id);
    }

    async updateComment(feedId:number,commentId:number,content:string):Promise<UpdateResult>{
        const feed = await this.feedRepository.findOne(feedId);
        if (!feed){
            throw new NotFoundException(`No feed with Id: ${feedId}`);
        }
        return this.commentRepository.updateComment(commentId,content)
    }

    async deleteComment(feedId:number,commentId:number,content:string):Promise<DeleteResult>{
        const feed = await this.feedRepository.findOne(feedId);
        if (!feed){
            throw new NotFoundException(`No feed with Id: ${feedId}`);
        }
        return this.commentRepository.softDelete(commentId)
    }

}
