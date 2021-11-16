import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from 'src/auth/model/user.entity';
import { ClubDTO } from '../model/club.dto';
import { Club } from '../model/club.entity';
import { ClubRepository } from '../repository/club.repository';

@Injectable()
export class ClubService {
    
    constructor(
        @InjectRepository(ClubRepository)
        private clubRepository:ClubRepository
    ){}

    createClub(clubDTO : ClubDTO,user:User):Promise<Club>{
        return this.clubRepository.createClub(clubDTO,user)
    }
}
