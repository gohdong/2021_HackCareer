import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AuthModule } from 'src/auth/auth.module';
import { FeedController } from './controller/feed.controller';
import { IsFeedCreatorGuard } from './guard/is-feed-creator.guard';
import { FeedRepository } from './repository/feed.repository';
import { FeedService } from './service/feed.service';
import { CommentController } from './controller/comment.controller';
import { CommentService } from './service/comment.service';
import { CommentRepository } from './repository/comment.repository';
import { IsCommentCreatorGuard } from './guard/is-comment-creator.guard';

@Module({
  imports : [
    AuthModule,
    TypeOrmModule.forFeature([FeedRepository,CommentRepository])
  ],
  controllers: [FeedController, CommentController],
  providers: [FeedService,IsFeedCreatorGuard,IsCommentCreatorGuard, CommentService]
})
export class FeedModule {}
