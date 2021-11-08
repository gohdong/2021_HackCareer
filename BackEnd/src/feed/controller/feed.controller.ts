import { Body, Controller, Delete, Get, Param, Post, Put, Query, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { GetUser } from 'src/auth/decoration/get-user.decorator';
import { User } from 'src/auth/model/user.entity';
import { IsCreatorGuard } from '../guard/is-creator.guard';
import { Feed } from '../model/feed.entity';
import { FeedDTO } from '../model/feed.dto';
import { FeedService } from '../service/feed.service';
import { DeleteResult, UpdateResult } from 'typeorm';

@Controller('feed')
@UseGuards(AuthGuard("jwt"))
export class FeedController {

    constructor(
        private feedService : FeedService,
    ){}

    @Get()
    findFeeds(
        @Query('take') take:number=1,
        @Query('skip') skip:number
        ):Promise<Feed[]>{
            take = take>20 ?20 : take;
            return this.feedService.findFeeds(take,skip)
    }

    @Get(":id")
    findFeedById(
        @Param('id') id:number
    ):Promise<Feed>{
        return this.feedService.findFeedById(id)
    }

    @Post()
    writeFeed(
        @GetUser() user:User,
        @Body() writeFeedDTO : FeedDTO
        ):Promise<Feed>{
        return this.feedService.writeFeed(user,writeFeedDTO)
    }

    @Put("/:id")
    @UseGuards(IsCreatorGuard)
    udpateFeed(
        @Param('id') id:number,
        @Body() feedDTO :FeedDTO
    ):Promise<UpdateResult>{
        return this.feedService.updateFeed(id,feedDTO);
    }

    @Delete("/:id")
    @UseGuards(IsCreatorGuard)
    deleteFeed(
        @Param('id') id:number,
    ):Promise<DeleteResult>{
        return this.feedService.deleteFeed(id);
    }
}
