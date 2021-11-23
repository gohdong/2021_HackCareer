import { User } from "src/auth/model/user.entity";
import { BaseEntity, Column, DeleteDateColumn, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { Feed } from "./feed.entity";

@Entity()
export class Comment extends BaseEntity{
    @PrimaryGeneratedColumn()
    id:number;

    @Column({nullable:false})
    content:string;

    @Column({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP'})
    createdAt : Date;

    @ManyToOne(()=>User, (user)=>user.comments,{lazy:true})
    writer: User;

    @ManyToOne(()=>Feed, (feed)=>feed.comments,{lazy:true})
    feed:Feed;
    
    @DeleteDateColumn({type:'timestamp'})
    deletedAt?:Date;
}