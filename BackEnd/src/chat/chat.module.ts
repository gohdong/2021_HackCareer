import { Module } from '@nestjs/common';
import { ChatGateway } from './gateway/chat.gateway';
import { AlertGateway } from './gateway/alert.gateway';
import { AlertController } from './controller/alert.controller';

@Module({
  providers: [ChatGateway, AlertGateway],
  controllers: [AlertController]
})
export class ChatModule {}
