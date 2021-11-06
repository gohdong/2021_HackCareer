import { Module } from '@nestjs/common';
import { PassportModule } from '@nestjs/passport';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AuthStrategy } from './auth.strategy';
import { AuthController } from './controller/auth.controller';
import { UserRepository } from './repository/user.repository';
import { AuthService } from './service/auth.service';
import { UserController } from './controller/user.controller';
import { UserService } from './service/user.service';


@Module({

  imports:[PassportModule,
    TypeOrmModule.forFeature([UserRepository])],
  controllers: [AuthController, UserController],
  providers: [AuthStrategy,AuthService, UserService],
  exports:[AuthService,PassportModule]
})
export class AuthModule {}
