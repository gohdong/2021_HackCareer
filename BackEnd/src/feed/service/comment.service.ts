import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from 'src/auth/model/user.entity';
import { CommentRepository } from '../repository/comment.repository';
import { FeedRepository } from '../repository/feed.repository';
import { Comment } from '../model/comment.entity';

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

}
