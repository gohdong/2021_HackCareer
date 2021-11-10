import { Injectable } from "@nestjs/common";
import { PassportStrategy } from "@nestjs/passport";
import { InjectRepository } from "@nestjs/typeorm";
import { ExtractJwt ,Strategy} from "passport-jwt";
import { User } from "./model/user.entity";
import { UserRepository } from "./repository/user.repository";
import * as config from 'config'

const jwtConfig = config.get('jwt')

@Injectable()
export class AuthStrategy extends PassportStrategy(Strategy){
    constructor(
        @InjectRepository(UserRepository)
        private userRepository:UserRepository, 
    ){
        super({
            jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
            secretOrKey:jwtConfig.get('secretKey'),
        });
    }

    async validate(payload){
        const {user_id,email} = payload;
        const user:User = await this.userRepository.findOne({uid:user_id})
        return user;
    }
}