import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { timeStamp } from 'console';
import { getRepository, MoreThan, Timestamp, UpdateResult } from 'typeorm';
import { User } from '../model/user.entity';
import { UserRepository } from '../repository/user.repository';

@Injectable()
export class UserService {

    constructor(
        @InjectRepository(UserRepository)
    private userRepository : UserRepository
    ){}

    updateProfile(id:number,url:string):Promise<UpdateResult>{
        const user = new User()
        user.id = id;
        user.imagePath = url;
        return this.userRepository.update(id,user)
    }

    findUserByUid(uid:string):Promise<User>{
        return this.userRepository.findOneOrFail({uid});
    }

    getUserProfile(id:number):Promise<User>{
        return this.userRepository.findOneOrFail({id})
    }

    getMyInfo(user:User):Promise<User>{
        return this.userRepository.createQueryBuilder('user')
        .where(' user.id = :id',{id:user.id})
        .leftJoinAndSelect('user.joinedClubs',"member")
        .withDeleted()
        .leftJoinAndSelect('user.createdClubs','club')
        .withDeleted()
        .getOne();
    }

}
