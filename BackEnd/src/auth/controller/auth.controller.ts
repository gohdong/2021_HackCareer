import { Body, Controller, Post, Request, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { InjectRepository } from '@nestjs/typeorm';
import { GetUser } from '../decoration/get-user.decorator';
import { SignupDTO } from '../model/signup.dto';
import { User } from '../model/user.entity';
import { UserRepository } from '../repository/user.repository';
import { AuthService } from '../service/auth.service';

@Controller('auth')
export class AuthController {

    constructor(
        private authService : AuthService,
    ){}

    @Post("/signup")
    async signup(
        @Body() signupDto : SignupDTO
    ):Promise<User>{
        return this.authService.signup(signupDto)
    }

    @Post('/test')
    @UseGuards(AuthGuard('jwt'))
    test(@GetUser() user:User){
        console.log(user)
    }
}
