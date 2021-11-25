import { ConflictException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Club } from 'src/club/model/club.entity';
import { ClubRepository } from 'src/club/repository/club.repository';
import { DeleteResult } from 'typeorm';
import { LikeClub } from '../model/like-club.entity';
import { User } from '../model/user.entity';
import { LikeClubRepository } from '../repository/like-club.repository';

@Injectable()
export class LikeClubService {
    constructor(
        @InjectRepository(LikeClubRepository)
        private likeClubRepository : LikeClubRepository,
        @InjectRepository(ClubRepository)
        private clubRepository : ClubRepository
    ){
    }

    async createLike(user:User,clubId:number):Promise<LikeClub>{
        try {
            return this.clubRepository.findOneOrFail(clubId,{
            }).then((club:Club)=>{
                const likeClub : LikeClub = this.likeClubRepository.create({user,club})
                return this.likeClubRepository.save(likeClub);
            });
        } catch (error) {
            throw new ConflictException(`Already Liked`)
            
        }
    }

    async deleteLike(user:User,clubId:number):Promise<DeleteResult>{
        try{
            return this.clubRepository.findOneOrFail(clubId).then((club:Club)=>{
                return this.likeClubRepository.delete({
                    club,user
                });
                
            })
        }catch (error) {
            throw new ConflictException(`Not exist Liked`)
            
        }
    }
    
}
