import { Body, Controller, Post, UploadedFile, UseGuards, UseInterceptors, ValidationPipe } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { FileInterceptor } from '@nestjs/platform-express';
import { GetUser } from 'src/auth/decoration/get-user.decorator';
import { User } from 'src/auth/model/user.entity';
import { BodyInterceptor } from '../helper/club-opt.interceptor';
import { saveClubImageToStorage } from '../helper/club-storage';
import { ClubDTO } from '../model/club.dto';
import { Club } from '../model/club.entity';
import { ClubService } from '../service/club.service';

@Controller('club')
@UseGuards(AuthGuard('jwt'))
export class ClubController {
    constructor(
        private clubService : ClubService
    ){}

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
}
