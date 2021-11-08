import { Controller, Post, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { FeedService } from '../service/feed.service';

@Controller('feed')
export class FeedController {

    constructor(
        private feedService : FeedService,
    ){}

    @Post()
    @UseGuards(AuthGuard("jwt"))
    writeFeed(){
        console.log('write feed')
    }
}
