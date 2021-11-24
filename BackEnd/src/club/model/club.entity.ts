import { User } from "src/auth/model/user.entity";
import { Message } from "src/chat/model/message.entity";
import { BaseEntity, Column, DeleteDateColumn, Entity, ManyToOne, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { ClubCategory } from "./club-catecory.entity";
import { ClubCategoryEnum } from "./club.enum";
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

    @Column({nullable:false, default:false})
    isCanceled : boolean;

    @Column("text", { array: true })
    hashTags: string[];

    @Column({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP'})
    createdAt : Date;

    @DeleteDateColumn({type:'timestamp'})
    deletedAt?: Date;

    @ManyToOne(()=>ClubCategory,(clubCatecory)=>clubCatecory.categoryTitle,{nullable:false})
    category: ClubCategory;

    @ManyToOne(()=>User,(user)=>user.createdClubs,{eager:false,lazy:true})
    leader : User

    @OneToMany(()=>Member,(member)=>member.club,{eager:false,lazy:true,cascade:true,onDelete:"CASCADE"})
    members : Member[]

    @OneToMany(()=>Message,(message)=>message.club)
    messages : Message[]
}