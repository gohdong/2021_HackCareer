import { Controller, Get, UseGuards } from '@nestjs/common';
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
        @GetUser() user:User
    ){
        return this.memberService.getLiveClub(user);
    }
    @Get('myClubLog')
    getClubLog(
        @GetUser() user:User
    ){
        return this.memberService.getClubLog(user);
    }

    
}
