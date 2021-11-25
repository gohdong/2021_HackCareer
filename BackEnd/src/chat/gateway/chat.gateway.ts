import { Logger } from '@nestjs/common';
import { OnGatewayConnection, OnGatewayDisconnect, OnGatewayInit, SubscribeMessage, WebSocketGateway, WebSocketServer, WsResponse } from '@nestjs/websockets';
import {Server, Socket} from 'socket.io'
import { ChatService } from '../service/chat.service';
@WebSocketGateway(4000,{cors:{origin:'*'} ,namespace:'/chat'})
// @WebSocketGateway(81, { namespace: 'chat' })
export class ChatGateway implements OnGatewayInit,OnGatewayConnection,OnGatewayDisconnect{
  constructor(
    private chatService :ChatService,
  ){}

  private logger:Logger = new Logger('ChatGateway')

  @WebSocketServer()
  wss :Server;

  afterInit(server: any) {
    this.logger.log('Init Gateway')
  }

  handleConnection(client: any, ...args: any[]) {
    console.log(`connection made ${client.id}`);
  }

  handleDisconnect(client: any) {
    console.log(`disconnected ${client.id}`)
  }

  @SubscribeMessage('chatToServer')
  handleMessage(socket:Socket, message:{sender:number, room:number, content:string}):Promise<any>{
    console.log(message);
    return this.chatService.saveMessage(message.sender,message.room,message.content).then((_)=>{
      this.wss.to(String(message.room)).emit('chatToClient',message);
    })
  }

  @SubscribeMessage('joinRoom')
  handleJoinRoom(client:Socket, room:number){
    client.join(String(room));
    return this.chatService.loadMessage(room).then((data)=>{
      client.emit('joinedRoom',data);
    })
  }

  @SubscribeMessage('leaveRoom')
  handleLeaveRoom(client:Socket, room:number){
    client.leave(String(room));
    client.emit('leftRoom',room);
  }
}
