import { Module } from '@nestjs/common';
import { ChatGateway } from './gateway/chat.gateway';
import { AlertGateway } from './gateway/alert.gateway';
import { AlertController } from './controller/alert.controller';
import { ChatController } from './controller/chat.controller';
import { ChatService } from './service/chat.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { MessageRepository } from './repository/message.repository';
import { AuthModule } from 'src/auth/auth.module';
import { ClubModule } from 'src/club/club.module';

@Module({
  imports:[
    AuthModule,
    ClubModule,
    TypeOrmModule.forFeature([MessageRepository,])],
  providers: [ChatGateway, AlertGateway, ChatService],
  controllers: [AlertController, ChatController],
})
export class ChatModule {}
