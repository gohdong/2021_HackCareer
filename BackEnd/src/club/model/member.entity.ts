import { User } from "src/auth/model/user.entity";
import { BaseEntity, Column, CreateDateColumn, DeleteDateColumn, Entity, ManyToOne, PrimaryGeneratedColumn, Unique } from "typeorm";
import { Club } from "./club.entity";

@Entity()
export class Member extends BaseEntity{
    @PrimaryGeneratedColumn()
    id:number;

    @Column({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP'})
    createdAt:Date;

    @DeleteDateColumn({type:'timestamp'})
    deletedAt?:Date;

    @ManyToOne(()=>Club,(club)=>club.members,{eager:true})
    club:Club;

    @ManyToOne(()=>User,(user)=>user.joinedClubs,{eager:true})
    user:User;
}