import { CanActivate, ExecutionContext, Injectable, NotFoundException } from "@nestjs/common";
import { Observable } from "rxjs";
import { User } from "src/auth/model/user.entity";
import { UserService } from "src/auth/service/user.service";
import { Comment } from "../model/comment.entity";
import { CommentService } from "../service/comment.service";

@Injectable()
export class IsCommentCreatorGuard implements CanActivate{
    constructor(
        private userService:UserService,
        private commentService:CommentService
    ){}


    canActivate(context: ExecutionContext): boolean | Promise<boolean> | Observable<boolean> {
        
        const request= context.switchToHttp().getRequest();
        const { user, params} :{user:User;params:{commentId:number}} = request;
        
        
        if(!user || !params) return false;

        if(user.role == 'admin') return true;

        const userUid = user.uid;
        const commentId = params.commentId;

        return this.userService.findUserByUid(userUid).then((user:User)=>{
            return this.commentService.findCommentById(commentId).then((comment:Comment)=>{
                if(!comment){
                    return false;
                }
                if(comment.writer.id === user.id){
                    return true;
                }
                return false;
            })
        })
    }
}