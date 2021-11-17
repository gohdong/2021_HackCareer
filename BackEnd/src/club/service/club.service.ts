import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from 'src/auth/model/user.entity';
import { UpdateResult } from 'typeorm';
import { ClubDTO } from '../model/club.dto';
import { Club } from '../model/club.entity';
import { ClubRepository } from '../repository/club.repository';
import { MemberRepository } from '../repository/member.repository';
import { MemberService } from './member.service';

@Injectable()
export class ClubService {
    
    constructor(
        @InjectRepository(ClubRepository)
        private clubRepository:ClubRepository,
        private memberService : MemberService
    ){}

    findClubs(take:number,skip:number):Promise<Club[]>{
        return this.clubRepository.findAndCount({
            take,skip,
            relations:["leader"],
            loadRelationIds:{
                relations:['members']
            }
        }).then(([clubs])=>{
            if(clubs.length == 0){
                throw new NotFoundException(`No Clubs`)
            }
            return clubs
        })
    }

    findClubById(id:number):Promise<Club>{
        return this.clubRepository.findClubById(id);
    }

    async updateClub(id:number,clubDTO:ClubDTO):Promise<UpdateResult>{
        const {
            title,
            description,
            imagePath,
            timeLimit,
            numLimit,
            isThunder} = clubDTO;

        return this.clubRepository.findOneOrFail({id}).then((club:Club)=>{
            const removedImage = imagePath===club.imagePath? club.imagePath:null;
            club.title = title;
            club.description = description;
            club.imagePath = imagePath;
            club.timeLimit = timeLimit;
            club.numLimit = numLimit;
            club.isThunder = isThunder
            return this.clubRepository.update(club.id,club).then((result)=>{
                if(removedImage){
                    // revomedImage 처리
                }
                return result;
            })
        })

    }

    async createClub(clubDTO : ClubDTO,user:User):Promise<Club>{
        const {
            title,
            description,
            imagePath,
            timeLimit,
            numLimit,
            isThunder} = clubDTO;

        const club =  Club.create({
            title,
            description,
            imagePath,
            timeLimit,
            numLimit,
            isThunder,
            leader:user
        })
        return this.clubRepository.save(club).then((club:Club)=>{
            return  this.memberService.joinClub(user,club.id).then((_)=>{
                return club
            })
        })
    }


    deleteClub(id:number):Promise<Club>{
        return this.clubRepository.findOneOrFail({id},{
            relations:['members']
        }).then((member)=>{
            return this.clubRepository.softRemove(member);
        })
    }
}
