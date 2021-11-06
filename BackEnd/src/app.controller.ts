import { Controller, Get, Req, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { Request } from 'express';
import { json } from 'stream/consumers';
import { AppService } from './app.service';

@Controller()
export class AppController {
  constructor() {}
  
  @UseGuards(AuthGuard('jwt'))
  @Get("/hello")
  getHello(@Req() request:Request): string {
    console.log("User",JSON.stringify(request['user']));
    return 'Hello' + JSON.stringify(request['user'])+'!';
  }
}
