import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from 'src/auth/model/user.entity';
import { Any, getRepository, In, Like, Raw, UpdateResult } from 'typeorm';
import { ClubCategory } from '../model/club-catecory.entity';
import { ClubCreateDTO } from '../model/club-create.dto';
import { ClubUpdateDTO } from '../model/club-update.dto';
import { Club } from '../model/club.entity';
import { ClubCatecoryRepository } from '../repository/club-category.repository';
import { ClubRepository } from '../repository/club.repository';
import { MemberRepository } from '../repository/member.repository';
import { MemberService } from './member.service';

@Injectable()
export class ClubService {
    
    constructor(
        @InjectRepository(ClubRepository)
        private clubRepository:ClubRepository,
        private memberService : MemberService,
        @InjectRepository(ClubCatecoryRepository)
        private clubCategoryRepository : ClubCatecoryRepository,
    ){}

    getClubChat(id:number){
        return this.clubRepository.findOneOrFail(id,{
            relations:['messages','messages.sender']
        });
    }

    findClubs(take:number,skip:number,selectedCategory?:string):Promise<Club[]>{
        return selectedCategory?this.clubRepository.findAndCount({
            take,skip,
            relations:["leader","category"],
            loadRelationIds:{
                relations:['members']
            },
            where:{
                category:{categoryTitle:selectedCategory}
            }
        }).then(([clubs])=>{
            if(clubs.length == 0){
                throw new NotFoundException(`No Clubs`)
            }
            return clubs
        }):
        this.clubRepository.findAndCount({
            take,skip,
            relations:["leader","category"],
            loadRelationIds:{
                relations:['members']
            },
        }).then(([clubs])=>{
            if(clubs.length == 0){
                throw new NotFoundException(`No Clubs`)
            }
            return clubs
        })
    }

    findClubByKeyword(take:number,skip:number,keyword:string):Promise<Club[]>{
        return this.clubRepository.findAndCount({
            take,skip,
            relations:["leader","category"],
            loadRelationIds:{
                relations:['members']
            },
            where:[
                {hashTags:Raw((hashTags)=>`${hashTags} @> '{${keyword}}'`)},
                {title: Like(`%${keyword}%`)},
            ]
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

    async updateClub(id:number,clubDTO:ClubUpdateDTO):Promise<UpdateResult>{
        const {
            title,
            description,
            newImagePath,
            timeLimit,
            numLimit,
            isThunder,
        } = clubDTO;

        const clubCategory = await this.clubCategoryRepository.findOneOrFail({categoryTitle:clubDTO.category})

        return this.clubRepository.findOneOrFail({id}).then((club:Club)=>{
            const removedImage = newImagePath? club.imagePath:null;
            club.title = title;
            club.description = description;
            club.imagePath = newImagePath?? club.imagePath;
            club.timeLimit = timeLimit;
            club.numLimit = numLimit;
            club.isThunder = isThunder;
            club.category = clubCategory
            return this.clubRepository.update(club.id,club).then((result)=>{
                if(removedImage){
                    // revomedImage 처리
                }
                return result;
            })
        })

    }

    async createClub(clubDTO : ClubCreateDTO,user:User):Promise<Club>{
        const {
            title,
            description,
            imagePath,
            timeLimit,
            numLimit,
            isThunder,
        } = clubDTO;

        const clubCategory = await this.clubCategoryRepository.findOneOrFail({categoryTitle:clubDTO.category})
        

        const club =  Club.create({
            title,
            description,
            imagePath,
            timeLimit,
            numLimit,
            isThunder,
            leader:user,
            category:clubCategory
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
        }).then((club)=>{
            return this.clubRepository.softRemove(club);
        })
    }

    cancelClub(id:number){
        return this.clubRepository.findOneOrFail(id,{
            relations:['members']
        }).then((club)=>{
            club.isCanceled = true;
            return this.clubRepository.save(club).then((editedClub)=>{
                return this.clubRepository.softRemove(editedClub);
            })
        })
    }
}
