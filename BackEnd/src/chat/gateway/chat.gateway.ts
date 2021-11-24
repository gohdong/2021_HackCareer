import { Logger } from '@nestjs/common';
import { OnGatewayConnection, OnGatewayDisconnect, OnGatewayInit, SubscribeMessage, WebSocketGateway, WebSocketServer, WsResponse } from '@nestjs/websockets';
import {Server, Socket} from 'socket.io'
@WebSocketGateway(4000,{cors:{origin:'*'} ,namespace:'/chat'})
// @WebSocketGateway(81, { namespace: 'chat' })
export class ChatGateway implements OnGatewayInit,OnGatewayConnection,OnGatewayDisconnect{

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
  handleMessage(socket:Socket, message:{sender:string, room:string, message:string}):void{
    // console.log(`${socket.id}: `,message)
    this.wss.to(message.room).emit('chatToClient',message);
  }

  @SubscribeMessage('joinRoom')
  handleJoinRoom(client:Socket, room:string){
    client.join(room);
    client.emit('joinedRoom',room);
  }

  @SubscribeMessage('leaveRoom')
  handleLeaveRoom(client:Socket, room:string){
    client.leave(room);
    client.emit('leftRoom',room);
  }
}
