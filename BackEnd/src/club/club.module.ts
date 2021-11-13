import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AuthModule } from 'src/auth/auth.module';
import { ClubController } from './controller/club.controller';
import { ClubRepository } from './repository/club.repository';
import { ClubService } from './service/club.service';

@Module({
  imports:[
    AuthModule,
    TypeOrmModule.forFeature([ClubRepository])
  ],
  controllers: [ClubController,
  ],
  providers: [ClubService]
})
export class ClubModule {}
