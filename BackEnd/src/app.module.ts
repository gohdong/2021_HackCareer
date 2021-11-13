import { MiddlewareConsumer, Module, NestModule, RequestMethod } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthModule } from './auth/auth.module';
import { typeORMConfig } from './config/typeorm.config';
import { ChatModule } from './chat/chat.module';
import { FeedModule } from './feed/feed.module';
import { ClubModule } from './club/club.module';

@Module({
  imports: [
    TypeOrmModule.forRoot(typeORMConfig),
    AuthModule,
    ChatModule,
    FeedModule,
    ClubModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule{}
