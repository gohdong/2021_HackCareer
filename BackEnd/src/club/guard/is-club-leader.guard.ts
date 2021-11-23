import { CanActivate, ExecutionContext, Injectable } from "@nestjs/common";
import { Observable } from "rxjs";
import { User } from "src/auth/model/user.entity";
import { UserService } from "src/auth/service/user.service";
import { FeedService } from "src/feed/service/feed.service";
import { Club } from "../model/club.entity";
import { ClubService } from "../service/club.service";


@Injectable()
export class IsClubLeaderGuard implements CanActivate{
    constructor(
        private userService:UserService,
        private clubService:ClubService
    ){}


    canActivate(context: ExecutionContext): boolean | Promise<boolean> | Observable<boolean> {
        
        const request= context.switchToHttp().getRequest();
        const { user, params} :{user:User;params:{id:number}} = request;
        
        if(!user || !params) return false;

        if(user.role == 'admin') return true;

        const userUid = user.uid;
        const clubId = params.id;

        return this.userService.findUserByUid(userUid).then((user:User)=>{
            return this.clubService.findClubById(clubId).then((club:Club)=>{
                
                if(club["__leader__"].id === user.id){
                    return true;
                }
                return false;
            })
        })
    }
}