import { Injectable } from '@nestjs/common';
import { EntityManager, Timestamp } from 'typeorm';
import { User } from './auth/model/user.entity';
import { Department, Gender, Role } from './auth/model/user.enum';
import { Feed } from './feed/model/feed.entity';
import { FeedCategoryEnum } from './feed/model/feed.enum';

@Injectable()
export class AppService {


  getHello(): string {
    return 'Hello World!';
  }
}
