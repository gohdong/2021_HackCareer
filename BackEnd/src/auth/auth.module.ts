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


@Module({

  imports:[
    forwardRef(() => FeedModule),
    PassportModule,
    TypeOrmModule.forFeature([UserRepository,LikeFeedRepository])],
  controllers: [AuthController, UserController],
  providers: [AuthStrategy,AuthService, UserService,LikeFeedService],
  exports:[AuthService,PassportModule,UserService,LikeFeedService]
})
export class AuthModule {}
