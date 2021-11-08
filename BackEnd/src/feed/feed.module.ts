import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AuthModule } from 'src/auth/auth.module';
import { FeedController } from './controller/feed.controller';
import { IsCreatorGuard } from './guard/is-creator.guard';
import { FeedRepository } from './repository/feed.repository';
import { FeedService } from './service/feed.service';

@Module({
  imports : [
    AuthModule,
    TypeOrmModule.forFeature([FeedRepository])
  ],
  controllers: [FeedController],
  providers: [FeedService,IsCreatorGuard]
})
export class FeedModule {}
