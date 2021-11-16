import { CanActivate, ExecutionContext, Injectable } from "@nestjs/common";
import { Observable } from "rxjs";
import { User } from "src/auth/model/user.entity";
import { UserService } from "src/auth/service/user.service";
import { Feed } from "../model/feed.entity";
import { FeedService } from "../service/feed.service";

@Injectable()
export class IsFeedCreatorGuard implements CanActivate{
    constructor(
        private userService:UserService,
        private feedService:FeedService
    ){}


    canActivate(context: ExecutionContext): boolean | Promise<boolean> | Observable<boolean> {
        
        const request= context.switchToHttp().getRequest();
        const { user, params} :{user:User;params:{id:number}} = request;
        
        if(!user || !params) return false;

        if(user.role == 'admin') return true;

        const userUid = user.uid;
        const feedId = params.id;

        return this.userService.findUserByUid(userUid).then((user:User)=>{
            return this.feedService.findFeedById(feedId).then((feed:Feed)=>{
                console.log(user)
                console.log(feed)
                
                if(feed.writer.id === user.id){
                    return true;
                }
                return false;
            })
        })
    }
}