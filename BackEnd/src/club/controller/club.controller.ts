import { Body, Controller, Delete, Get, Param, Post, Put, Query, UploadedFile, UseGuards, UseInterceptors, ValidationPipe } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { FileInterceptor } from '@nestjs/platform-express';
import { GetUser } from 'src/auth/decoration/get-user.decorator';
import { LikeClub } from 'src/auth/model/like-club.entity';
import { User } from 'src/auth/model/user.entity';
import { LikeClubService } from 'src/auth/service/like-club.service';
import { DeleteResult, UpdateResult } from 'typeorm';
import { IsClubLeaderGuard } from '../guard/is-club-leader.guard';
import { BodyInterceptor } from '../helper/club-opt.interceptor';
import { saveClubImageToStorage } from '../helper/club-storage';
import { ClubCreateDTO } from '../model/club-create.dto';
import { ClubUpdateDTO } from '../model/club-update.dto';
import { Club } from '../model/club.entity';
import { Member } from '../model/member.entity';
import { ClubService } from '../service/club.service';
import { MemberService } from '../service/member.service';

@Controller('club')
@UseGuards(AuthGuard('jwt'))
export class ClubController {
    constructor(
        private clubService : ClubService,
        private memberService: MemberService,
        private likeClubService : LikeClubService,
    ){}

    @Get()
    findClubs(
        @GetUser() user:User,
        @Query('take') take:number=1,
        @Query('skip') skip:number,
        @Query('category') category:string,
        @Query('isNow') now:string,
        ):Promise<Club[]>{
            take = take>20 ?20 : take;
            const isNow = now=='false'?false:true;
            
            return Boolean(isNow)?this.clubService.findNows(user,take,skip,category):this.clubService.findClubs(take,skip,category)
    }

    @Get('my')
    getMyClub(
        @GetUser() user:User
    ){
        return this.clubService.getMyClub(user);
    }
    @Get('my/log')
    getMyClubLog(
        @GetUser() user:User
    ){
        return this.clubService.getMyClubLog(user);
    }

    @Get("/search")
    findClubByKeyword(
        @Query('take') take:number=1,
        @Query('skip') skip:number,
        @Query('keyword') keyword:string,
        @Query('category') category:string,
        ):Promise<Club[]>{
            take = take>20 ?20 : take;
            return this.clubService.findClubByKeyword(take,skip,keyword,category)
    }

    @Get("/:id/chat")
    getClubChat(
        @Param("id") id:number
    ){
        return this.clubService.getClubChat(id);
    }

    @Get("/:id")
    findClubById(
        @Param('id') id:number
    ):Promise<Club>{
        return this.clubService.findClubById(id)
    }

    @Post()
    @UseInterceptors(FileInterceptor('file',saveClubImageToStorage),BodyInterceptor)
    createClub(
        @GetUser() user:User,
        @UploadedFile() file:Express.Multer.File,
        @Body() clubDTO : ClubCreateDTO
        ):Promise<Club>{
            clubDTO.imagePath = file?file['publicUrl']:null;
            return this.clubService.createClub(clubDTO,user);
    }

    @Put(":id")
    @UseGuards(IsClubLeaderGuard)
    @UseInterceptors(FileInterceptor('file',saveClubImageToStorage),BodyInterceptor)
    updateClub(
        @Param('id') id:number,
        @UploadedFile() file:Express.Multer.File,
        @Body() clubDTO : ClubUpdateDTO
        ):Promise<UpdateResult>{
            clubDTO.newImagePath = file?file['publicUrl']:null;
            
            return this.clubService.updateClub(id,clubDTO);
        }
    

    @Delete(":id")
    @UseGuards(IsClubLeaderGuard)
    deleteClub(
        @Param('id') id:number,
    ):Promise<Club>{
        return this.clubService.deleteClub(id);
    }

    @Put("/:id/cancel")
    @UseGuards(IsClubLeaderGuard)
    cancelClub(
        @Param('id') id:number,
    ){
        return this.clubService.cancelClub(id);
    }

    // like =========================================

    @Post("/:clubId/like")
    createLike(
        @GetUser() user:User,
        @Param('clubId') clubId:number
    ):Promise<LikeClub>{
        return this.likeClubService.createLike(user,clubId);
    }

    @Post("/:clubId/unlike")
    deleteLike(
        @GetUser() user:User,
        @Param('clubId') clubId:number
    ):Promise<DeleteResult>{
        return this.likeClubService.deleteLike(user,clubId);
    }


    // member =============================================

    @Post("/:clubId/member")
    joinClub(
        @GetUser() user:User,
        @Param('clubId') clubId:number
    ):Promise<Member>{
        return this.memberService.joinClub(user,clubId);
    }

    @Delete("/:clubId/member")
    leftClub(
        @GetUser() user:User,
        @Param('clubId') clubId:number
    ):Promise<UpdateResult>{
        return this.memberService.leftClub(user,clubId);
    }


    
}
