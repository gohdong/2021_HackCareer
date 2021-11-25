import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AuthModule } from 'src/auth/auth.module';
import { ClubController } from './controller/club.controller';
import { ClubRepository } from './repository/club.repository';
import { ClubService } from './service/club.service';
import { MemberService } from './service/member.service';
import { MemberRepository } from './repository/member.repository';
import { IsClubLeaderGuard } from './guard/is-club-leader.guard';
import { ClubCatecoryRepository } from './repository/club-category.repository';
import {MemberController} from './controller/member.controller'

@Module({
  imports:[
    AuthModule,
    TypeOrmModule.forFeature([ClubRepository,MemberRepository,ClubCatecoryRepository])
  ],
  controllers: [ClubController, MemberController,
  ],
  providers: [ClubService, MemberService,IsClubLeaderGuard],
  exports:[TypeOrmModule.forFeature([ClubRepository])]
})
export class ClubModule {}
