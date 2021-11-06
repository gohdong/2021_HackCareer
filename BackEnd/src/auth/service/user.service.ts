import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { UpdateResult } from 'typeorm';
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

}
