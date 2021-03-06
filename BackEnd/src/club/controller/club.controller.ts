import { Body, Controller, Delete, Get, Param, Post, Put, Query, UploadedFile, UseGuards, UseInterceptors, ValidationPipe } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { FileInterceptor } from '@nestjs/platform-express';
import { GetUser } from 'src/auth/decoration/get-user.decorator';
import { User } from 'src/auth/model/user.entity';
import { UpdateResult } from 'typeorm';
import { IsClubLeaderGuard } from '../guard/is-club-leader.guard';
import { BodyInterceptor } from '../helper/club-opt.interceptor';
import { saveClubImageToStorage } from '../helper/club-storage';
import { ClubDTO } from '../model/club.dto';
import { Club } from '../model/club.entity';
import { Member } from '../model/member.entity';
import { ClubService } from '../service/club.service';
import { MemberService } from '../service/member.service';

@Controller('club')
@UseGuards(AuthGuard('jwt'))
export class ClubController {
    constructor(
        private clubService : ClubService,
        private memberService: MemberService
    ){}

    @Get()
    findClubs(
        @Query('take') take:number=1,
        @Query('skip') skip:number
        ):Promise<Club[]>{
            take = take>20 ?20 : take;
            return this.clubService.findClubs(take,skip)
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
        @Body() clubDTO : ClubDTO
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
        @Body() clubDTO : ClubDTO
        ):Promise<UpdateResult>{
            clubDTO.imagePath = file?file['publicUrl']:null;
            return this.clubService.updateClub(id,clubDTO);
        }
    

    @Delete(":id")
    @UseGuards(IsClubLeaderGuard)
    deleteClub(
        @Param('id') id:number,
    ):Promise<Club>{
        return this.clubService.deleteClub(id);
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
