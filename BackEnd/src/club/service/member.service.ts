import { ConflictException, ForbiddenException, Injectable, InternalServerErrorException, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from 'src/auth/model/user.entity';
import { DeleteResult, UpdateResult } from 'typeorm';
import { Member } from '../model/member.entity';
import { ClubRepository } from '../repository/club.repository';
import { MemberRepository } from '../repository/member.repository';

@Injectable()
export class MemberService {
    constructor(
        @InjectRepository(MemberRepository)
        private memberRepository : MemberRepository,
        @InjectRepository(ClubRepository)
        private clubRepository : ClubRepository
    ){}

    async joinClub(user:User,clubId:number):Promise<Member>{
        const club = await this.clubRepository.findClubById(clubId);
        
        
        return this.memberRepository.findOne({user,club}).then((member:Member)=>{
            if(member){
                throw new ForbiddenException(`Already joined`)
            }
            if(club.members.length >= club.numLimit){
                throw new ConflictException(`Full Member`);
            }
            const create = this.memberRepository.create({user,club})
            return this.memberRepository.save(create);
        })
    }

    async leftClub(user:User,clubId:number):Promise<UpdateResult>{
        const club = await this.clubRepository.findClubById(clubId);
        
        return this.memberRepository.findOne({user,club}).then((member:Member)=>{
            if(!member){
                throw new NotFoundException(`No Member Relation`);
            }
            // console.log(member);
            return this.memberRepository.softDelete(member.id);
        })
    }
}
