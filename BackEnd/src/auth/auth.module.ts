import { forwardRef, Module } from '@nestjs/common';
import { PassportModule } from '@nestjs/passport';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AuthStrategy } from './auth.strategy';
import { AuthController } from './controller/auth.controller';
import { UserRepository } from './repository/user.repository';
import { AuthService } from './service/auth.service';
import { UserController } from './controller/user.controller';
import { UserService } from './service/user.service';
import { LikeFeedRepository } from './repository/like-feed.repository';
import { LikeFeedService } from './service/like-feed.service';
import { FeedModule } from 'src/feed/feed.module';
import { LikeClubRepository } from './repository/like-club.repository';
import { LikeClubService } from './service/like-club.service';
import { ClubModule } from 'src/club/club.module';

@Module({
  imports:[
    forwardRef(() => FeedModule),
    forwardRef(() => ClubModule),
    PassportModule,
    TypeOrmModule.forFeature([UserRepository,LikeFeedRepository,LikeClubRepository])],
  controllers: [AuthController, UserController],
  providers: [AuthStrategy,AuthService, UserService,LikeFeedService, LikeClubService],
  exports:[AuthService,PassportModule,UserService,LikeFeedService,LikeClubService,TypeOrmModule.forFeature([UserRepository])]
})
export class AuthModule {}
