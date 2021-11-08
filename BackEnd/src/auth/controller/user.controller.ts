import { Body, Controller, Get, Post, Request, UploadedFile, UseGuards, UseInterceptors } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { FileInterceptor } from '@nestjs/platform-express';
import { UpdateResult } from 'typeorm';
import { GetUser } from '../decoration/get-user.decorator';
import { saveImageToStorage } from '../helper/image-storage';
import { User } from '../model/user.entity';
import { UserService } from '../service/user.service';

@Controller('user')
@UseGuards(AuthGuard('jwt'))
export class UserController {

    constructor(
        private userService : UserService
    ){}

    @Post('/profile')
    @UseInterceptors(FileInterceptor('file',saveImageToStorage))
    async uploadProfile(@GetUser() user:User, @UploadedFile() file:Express.Multer.File): Promise<UpdateResult | {error:string}>{
        return this.userService.updateProfile(user.id,file['publicUrl'])
    }

    @Get("/:uid")
    findUserByUid(uid:string):Promise<User>{
        return this.userService.findUserByUid(uid);
    }


}
