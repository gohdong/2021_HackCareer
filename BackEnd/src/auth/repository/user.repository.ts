import { ConflictException, InternalServerErrorException } from "@nestjs/common";
import { EntityRepository, Repository } from "typeorm";
import { SignupDTO } from "../model/signup.dto";
import { User } from "../model/user.entity";


@EntityRepository(User)
export class UserRepository extends Repository<User>{

    async createUser(signupDto:SignupDTO):Promise<User>{
        const {
            uid,
            email,
            nickname,
            studentNum,
            department,
            interest,
            gender,
            birth
        } = signupDto;

        const user:User = this.create({
            uid,
            email,
            nickname,
            studentNum,
            interest,
            department,
            gender,
            birth,
        });

        try {
            const resultUser = await this.save(user);
            return resultUser;
        } catch (error) {
            if(error.code === '23505'){
                throw new ConflictException('Existing email & uid');
            }else{
                throw new InternalServerErrorException();
            }
        }
    }
    
    
}