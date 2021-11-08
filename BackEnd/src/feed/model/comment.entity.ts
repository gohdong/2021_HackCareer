import { User } from "src/auth/model/user.entity";
import { BaseEntity, Column, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { Feed } from "./feed.entity";

@Entity()
export class Comment extends BaseEntity{
    @PrimaryGeneratedColumn()
    id:number;

    @Column({nullable:false})
    content:string;

    @Column({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP'})
    createdAt : Date;

    @ManyToOne(()=>User, (user)=>user.comments,{eager:true})
    writer: User;

    @ManyToOne(()=>Feed, (feed)=>feed.comments,{eager:false})
    feed:Feed;
}