import { Body, Controller, Delete, Get, Param, Post, Put, Query, Request, UploadedFiles, UseGuards, UseInterceptors } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { GetUser } from 'src/auth/decoration/get-user.decorator';
import { User } from 'src/auth/model/user.entity';
import { IsFeedCreatorGuard } from '../guard/is-feed-creator.guard';
import { Feed } from '../model/feed.entity';
import { FeedDTO } from '../model/feed.dto';
import { FeedService } from '../service/feed.service';
import { DeleteResult, UpdateResult } from 'typeorm';
import { CommentService } from '../service/comment.service';
import { Comment } from '../model/comment.entity';
import { IsCommentCreatorGuard } from '../guard/is-comment-creator.guard';
import { saveFeedImageToStorage } from '../helper/feed-storage';
import { FileFieldsInterceptor } from '@nestjs/platform-express';
import { BodyInterceptor } from '../helper/feed-opt.interceptor';
import { UpdateFeedDTO } from '../model/update-feed.dto';


@Controller('feed')
@UseGuards(AuthGuard("jwt"))
export class FeedController {

    constructor(
        private feedService : FeedService,
        private commentService : CommentService,
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
    @UseInterceptors(FileFieldsInterceptor([
        { name: 'files', maxCount: 10 },
      ],saveFeedImageToStorage),BodyInterceptor,)
    writeFeed(
        @GetUser() user:User,
        @Body() feedDTO:FeedDTO,
        @UploadedFiles() files: Array<Express.Multer.File>
    ):Promise<Feed>{
        const temp = JSON.parse(JSON.stringify(files))['files']
        const urls = temp?temp.map((file)=>file['publicUrl']):[];
        // const feedDTO :FeedDTO = new FeedDTO()
        // const opt :{description:string}= JSON.parse(raw);
        // feedDTO.description = opt.description;
        feedDTO.imagePath = urls;
        return this.feedService.writeFeed(user,feedDTO);
    }

    @Put("/:id")
    @UseInterceptors(FileFieldsInterceptor([
        { name: 'files', maxCount: 10 },
      ],saveFeedImageToStorage),BodyInterceptor)
    @UseGuards(IsFeedCreatorGuard)
    udpateFeed(
        @Param('id') id:number,
        @UploadedFiles() files: Array<Express.Multer.File>,
        @Body() updateFeedDTO:UpdateFeedDTO
    ):Promise<UpdateResult>{
        const temp = JSON.parse(JSON.stringify(files))['files']
        updateFeedDTO.addedImagePath = temp?temp.map((file)=>file['publicUrl']):[];
        
        
        return this.feedService.updateFeed(id,updateFeedDTO);
    }

    @Delete("/:id")
    @UseGuards(IsFeedCreatorGuard)
    deleteFeed(
        @Param('id') id:number,
    ):Promise<DeleteResult>{
        return this.feedService.deleteFeed(id);
    }

    @Post("/:feedId/comment")
    createComment(
        @Param("feedId") feedId:number,
        @GetUser() user:User,
        @Body("content") content:string
        ):Promise<Comment>{
            return this.commentService.createComment(user,feedId,content)
    }

    @Put("/:feedId/comment/:commentId")
    @UseGuards(IsCommentCreatorGuard)
    updateComment(
        @Param("feedId") feedId :number,
        @Param("commentId") commentId:number,
        @Body("content") content:string
    ):Promise<UpdateResult>{
        return this.commentService.updateComment(feedId,commentId,content)
    }

    @Delete("/:feedId/comment/:commentId")
    deleteComment(
        @Param("feedId") feedId :number,
        @Param("commentId") commentId:number,
        @Body("content") content:string
    ):Promise<DeleteResult>{
        return this.commentService.deleteComment(feedId,commentId,content)
    }
}
