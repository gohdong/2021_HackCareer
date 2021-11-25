import { ConflictException, ForbiddenException, Injectable, InternalServerErrorException, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { buildMessage } from 'class-validator';
import { User } from 'src/auth/model/user.entity';
import { DeleteResult, LessThanOrEqual, MoreThanOrEqual, UpdateResult } from 'typeorm';
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
        return this.clubRepository.findClubById(clubId).then((club)=>{
            return this.memberRepository.findOne({user,club}).then((member:Member)=>{
                if(member){
                    throw new ForbiddenException(`Already joined`)
                }
                if(club['__members__'].length >= club.numLimit){
                    throw new ConflictException(`Full Member`);
                }
                const create = this.memberRepository.create({user,club})
                return this.memberRepository.save(create);
            })
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

    getLiveClub(user:User){
        return this.memberRepository.find({
            loadRelationIds:{
                relations:['user'],
            },
            relations:['club','club.members'],
            where:{
                user: {id : user.id},
                club : {timeLimit: MoreThanOrEqual(new Date())}
            }
        })
    }
    getClubLog(user:User){
        return this.memberRepository.find({
            loadRelationIds:{
                relations:['user'],
            },
            relations:['club'],
            withDeleted:true,
            where:{
                user: {id : user.id},
                club : {timeLimit: LessThanOrEqual(new Date())}
            }
        })
    }
    





}
