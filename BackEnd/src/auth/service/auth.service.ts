import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { SignupDTO } from '../model/signup.dto';
import { User } from '../model/user.entity';
import { UserRepository } from '../repository/user.repository';

@Injectable()
export class AuthService {
    constructor(
        @InjectRepository(UserRepository)
        private userRepository : UserRepository,
    ){}

    async signup(signupDto : SignupDTO):Promise<User>{
        return this.userRepository.createUser(signupDto)
    }

    
}
