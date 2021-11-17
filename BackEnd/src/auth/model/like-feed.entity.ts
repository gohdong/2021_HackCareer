import { Feed } from "src/feed/model/feed.entity";
import { BaseEntity, Entity, ManyToOne, PrimaryGeneratedColumn, Unique } from "typeorm";
import { User } from "./user.entity";

@Entity()
@Unique(['user','feed'])
export class LikeFeed extends BaseEntity{

    @PrimaryGeneratedColumn()
    id:number;

    @ManyToOne(()=>User,(user)=>user.likeFeeds,{eager:false,lazy:true})
    user:User;

    @ManyToOne(()=>Feed,(feed)=>feed.likeUsers,{eager:false,lazy:true})
    feed:Feed;
}