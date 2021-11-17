import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from 'src/auth/model/user.entity';
import { UpdateResult } from 'typeorm';
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

    findClubById(id:number):Promise<Club>{
        return this.clubRepository.findClubById(id);
    }

    deleteClub(id:number):Promise<Club>{
        return this.clubRepository.findOneOrFail({id},{
            relations:['members']
        }).then((member)=>{
            return this.clubRepository.softRemove(member);
        })
        // return this.clubRepository.softDelete(id);
    }
}
