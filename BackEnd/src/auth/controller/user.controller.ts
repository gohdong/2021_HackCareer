import { Body, Controller, Get, Param, Post, Request, UploadedFile, UseGuards, UseInterceptors } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { FileInterceptor } from '@nestjs/platform-express';
import { UpdateResult } from 'typeorm';
import { GetUser } from '../decoration/get-user.decorator';
import { saveProfileImageToStorage } from '../helper/profile-storage';
import { User } from '../model/user.entity';
import { UserService } from '../service/user.service';

@Controller('user')
@UseGuards(AuthGuard('jwt'))
export class UserController {

    constructor(
        private userService : UserService
    ){}

    @Get('my')
    getMyInfo(
        @GetUser() user:User
    ){
        return this.userService.getMyInfo(user);
    }

    @Get('myClub')
    getMyClub(
        @GetUser() user:User
    ){
        return this.userService.getMyClub(user);
    }

    @Get('myClubLog')
    getMyClubLog(
        @GetUser() user:User
    ){
        return this.userService.getMyClubLog(user);
    }


    @Post('/profile')
    @UseInterceptors(FileInterceptor('file',saveProfileImageToStorage))
    async uploadProfile(@GetUser() user:User, @UploadedFile() file:Express.Multer.File): Promise<UpdateResult | {error:string}>{
        return this.userService.updateProfile(user.id,file['publicUrl'])
    }

    @Get('/:id/profile')
    getProfile(
        @Param("id") id:number
    ):Promise<User>{
        return this.userService.getUserProfile(id);
    }

    @Get("/:uid")
    findUserByUid(uid:string):Promise<User>{
        return this.userService.findUserByUid(uid);
    }


}
