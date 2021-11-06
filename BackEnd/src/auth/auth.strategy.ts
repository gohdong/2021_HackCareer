import { Injectable } from "@nestjs/common";
import { PassportStrategy } from "@nestjs/passport";
import { InjectRepository } from "@nestjs/typeorm";
import { ExtractJwt ,Strategy} from "passport-jwt";
import { User } from "./model/user.entity";
import { UserRepository } from "./repository/user.repository";

@Injectable()
export class AuthStrategy extends PassportStrategy(Strategy){
    constructor(
        @InjectRepository(UserRepository)
        private userRepository:UserRepository, 
    ){
        super({
            jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
            secretOrKey:"-----BEGIN CERTIFICATE-----\nMIIDHDCCAgSgAwIBAgIINE9qlOtyUm0wDQYJKoZIhvcNAQEFBQAwMTEvMC0GA1UE\nAxMmc2VjdXJldG9rZW4uc3lzdGVtLmdzZXJ2aWNlYWNjb3VudC5jb20wHhcNMjEx\nMDMxMDkyMDI1WhcNMjExMTE2MjEzNTI1WjAxMS8wLQYDVQQDEyZzZWN1cmV0b2tl\nbi5zeXN0ZW0uZ3NlcnZpY2VhY2NvdW50LmNvbTCCASIwDQYJKoZIhvcNAQEBBQAD\nggEPADCCAQoCggEBALrUuGFMFyK7W0reqBggI8g0GxXiFvTGIUMV2yImt3xVCYkx\n283823MS/L1FwXucq3ukf6SITlbm8DkGEuioMcMkutxzD+UTn8+6y3qLMEryIILh\nkvgyb5v3xpPrg+0wwJXSzAl3TTycds+4qfLUufP4achWBkC6bYyJH5fBDlOwQExu\nV1I+6voIHrckKAjO+/P1OUzo4TqYLBF5dUXR3/uj4V9VJwV5YSqZ+JWYRWrQN9yW\n2mPZuxWEn3j4B+1o3uam9Jt0M7UtspVBIIeEQSPhoD4Tkf6wOzRsT/WzmR69hV5t\nIfYvUqWEv+o1euF7GGHM6jGir8vovbEUMwOL+EMCAwEAAaM4MDYwDAYDVR0TAQH/\nBAIwADAOBgNVHQ8BAf8EBAMCB4AwFgYDVR0lAQH/BAwwCgYIKwYBBQUHAwIwDQYJ\nKoZIhvcNAQEFBQADggEBAF3StGGVAMi/0jpQ7rolhi0UtXPLVYlruDL9SAQJQ8ll\niVgXYY0R3LUQnptv68uM8od5SniL8fRL9NMUUAdlzGaOtT6bpKTP26RA7svoc+2a\n6n7En+YZO562ufHDJgk9KcuwM2luTAGWr+wlm36S8v4THpEA63bXEcrI6e2EKn0q\nF1EguuvJIQWehRy2GGHhYqXSvP3GotFc8gQyh5OiA6XG2wn1jkxayGxh+VTL+ujo\nsdfbHXip2aba3pV7KpDC8ibG2hOgIB91Qo3SkcEU6A1iG30UH2Kxr+xn9YO0jqU6\nCNPtpoKrTdKw5WIlZdsZPwE/7AVayah+2PItJ2yd7vs=\n-----END CERTIFICATE-----\n",
        });
    }

    async validate(payload){
        const {user_id,email} = payload;
        const user:User = await this.userRepository.findOne({uid:user_id})
        return user;
    }
}