import { Controller, Get, Param, Query, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { GetUser } from 'src/auth/decoration/get-user.decorator';
import { User } from 'src/auth/model/user.entity';
import { MemberService } from '../service/member.service';

@Controller('member')
@UseGuards(AuthGuard('jwt'))
export class MemberController {

    constructor(
        private memberService :MemberService
    ){}

    @Get('myLiveClub')
    getJoinedClub(
        @GetUser() user:User,
        @Query('isNow') now:string
    ){
        const isNow = now === 'true'?true:false
        return this.memberService.getLiveClub(user,isNow);
    }
    
    @Get('myClubLog')
    getClubLog(
        @GetUser() user:User,
        @Query('isNow') now:string
    ){
        const isNow = now === 'true'?true:false
        return this.memberService.getClubLog(user,isNow);
    }

    @Get(':clubId')
    getClubMembers(
        @Param('clubId') clubId:number,
    ){
        return this.memberService.getMembers(clubId);
    }

    
}
