import { OnGatewayConnection, OnGatewayDisconnect, SubscribeMessage, WebSocketGateway, WebSocketServer } from '@nestjs/websockets';
import {Server, Socket} from 'socket.io'
@WebSocketGateway({cors:{origin:['http://localhost:8100']}})
// @WebSocketGateway(81, { namespace: 'chat' })
export class ChatGateway implements OnGatewayConnection,OnGatewayDisconnect{

  @WebSocketServer()
  server :Server;


  handleConnection(client: any, ...args: any[]) {
    console.log('connection made')
  }

  handleDisconnect(client: any) {
    console.log('disconnected')
  }

  @SubscribeMessage('sendMessage')
  handleMessage(socket:Socket, message:String) {
    this.server.emit('newMessage',message)
  }
}
