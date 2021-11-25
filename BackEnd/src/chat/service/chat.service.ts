import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from 'src/auth/model/user.entity';
import { UserRepository } from 'src/auth/repository/user.repository';
import { Club } from 'src/club/model/club.entity';
import { ClubRepository } from 'src/club/repository/club.repository';
import { MessageRepository } from '../repository/message.repository';

@Injectable()
export class ChatService {

    constructor(
        @InjectRepository(MessageRepository)
        private messageRepository: MessageRepository,
        @InjectRepository(ClubRepository)
        private clubRepository:ClubRepository,
        @InjectRepository(UserRepository)
        private userRepository:UserRepository
    ){}

    async saveMessage(userId:number,clubId:number,message:string){

        return this.clubRepository.findOneOrFail({id:clubId}).then((club:Club)=>{
            return this.userRepository.findOneOrFail({id:userId}).then((user:User)=>{
                return this.messageRepository.saveMessage(user,club,message);
            })
        })
        
    }

    loadMessage(clubId:number){
        return this.messageRepository.find({
            loadRelationIds:{
                relations:['club']
            },
            relations:['sender'],
            where:{
                club:{id : clubId}
            }
        });
    }


}
