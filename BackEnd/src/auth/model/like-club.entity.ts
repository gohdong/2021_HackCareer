import { Club } from "src/club/model/club.entity";
import { BaseEntity, Entity, ManyToOne, PrimaryGeneratedColumn, Unique } from "typeorm";
import { User } from "./user.entity";

@Entity()
@Unique(['user','club'])
export class LikeClub extends BaseEntity{

    @PrimaryGeneratedColumn()
    id:number;

    @ManyToOne(()=>User,(user)=>user.likeClubs,{eager:false,lazy:true})
    user:User;

    @ManyToOne(()=>Club, (club)=> club.likeUsers,{eager:false,lazy:true})
    club : Club;

    
}