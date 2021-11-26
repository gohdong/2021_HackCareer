import { Controller, Get, Param, Post, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { GetUser } from 'src/auth/decoration/get-user.decorator';
import { User } from 'src/auth/model/user.entity';
import { ChatService } from '../service/chat.service';

@Controller('chat')
@UseGuards(AuthGuard('jwt'))
export class ChatController {

    constructor(
        private chatService : ChatService
    ){}

    @Post()
    sendMessage(
        @GetUser() user:User,
        
    ){

    }
    @Get("/:id")
    getMessages(
        @Param("id") id:number
    ){
    return this.chatService.loadMessage(id)  
    }


    
}
