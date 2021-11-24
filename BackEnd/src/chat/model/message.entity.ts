import { User } from "src/auth/model/user.entity";
import { Club } from "src/club/model/club.entity";
import { BaseEntity, Column, CreateDateColumn, DeleteDateColumn, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm";


@Entity()
export class Message extends BaseEntity{
    @PrimaryGeneratedColumn()
    id:number;

    @Column({nullable:false})
    content:string;

    @CreateDateColumn({type:'timestamp'})
    createdAt:Date;

    @DeleteDateColumn({type:'timestamp'})
    deletedAt:Date;

    @ManyToOne(()=>User,(user)=>user.messages)
    sender:User;

    @ManyToOne(()=>Club,(club)=>club.messages)
    club:Club;



}