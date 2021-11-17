import { User } from "src/auth/model/user.entity";
import { BaseEntity, Column, DeleteDateColumn, Entity, ManyToOne, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { Member } from "./member.entity";

@Entity()
export class Club extends BaseEntity{
    @PrimaryGeneratedColumn()
    id :number;

    @Column({nullable:false})
    title: string;

    @Column({nullable:false})
    description: string;

    @Column({nullable:true})
    imagePath : string;

    @Column({nullable:false,type: 'timestamp'})
    timeLimit: Date;

    @Column({nullable:false})
    numLimit: number;

    @Column({nullable:false})
    isThunder : boolean;

    @Column({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP'})
    createdAt : Date;

    @DeleteDateColumn({type:'timestamp'})
    deletedAt?: Date;

    @ManyToOne(()=>User,(user)=>user.createdClubs,{eager:true})
    leader : User

    @OneToMany(()=>Member,(member)=>member.club,{cascade:true,onDelete:"CASCADE"})
    members : Member[]

}