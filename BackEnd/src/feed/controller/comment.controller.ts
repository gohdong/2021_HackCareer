import { Controller, Post, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { CommentService } from '../service/comment.service';

@Controller('comment')
@UseGuards(AuthGuard("jwt"))
export class CommentController {
    constructor( 
        commentService : CommentService
        ){}

}
