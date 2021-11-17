import { Optional } from "@nestjs/common";
import { User } from "src/auth/model/user.entity";
import { BaseEntity, Column, DeleteDateColumn, Entity, ManyToOne, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { Comment } from 'src/feed/model/comment.entity'

@Entity()
export class Feed extends BaseEntity{
    @PrimaryGeneratedColumn()
    id:number;

    @Column({nullable:false})
    description:string;

    @Optional()
    @Column({array:true,type:'text',default:null})
    imagePath:string[];

    @Column({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP'})
    createdAt : Date;

    @DeleteDateColumn({type:'timestamp'})
    deletedAt?:Date;

    @ManyToOne(()=>User, (user)=>user.feeds,{eager:true})
    writer:User;

    @OneToMany(()=>Comment,(comment)=>comment.feed,{lazy:true,cascade:true,onDelete:"CASCADE"})
    comments :Comment[]

}