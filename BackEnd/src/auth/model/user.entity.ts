import { Feed } from 'src/feed/model/feed.entity';
import {BaseEntity, Column, Entity, OneToMany, PrimaryColumn, PrimaryGeneratedColumn, Unique} from 'typeorm'
import { Department, Gender, Interest, Role } from './user.enum';
import {Comment} from '../../feed/model/comment.entity'
import { Club } from 'src/club/model/club.entity';
import { Member } from 'src/club/model/member.entity';
import { LikeFeed } from './like-feed.entity';
import { Message } from 'src/chat/model/message.entity';
import { LikeClub } from './like-club.entity';



@Entity()
export class User extends BaseEntity{
    @PrimaryGeneratedColumn()
    id: number;
    
    @Column({nullable:false,unique:true})
    uid: string;

    @Column({nullable:false,unique:true})
    email: string;

    @Column({nullable:false})
    nickname : string;

    @Column({nullable:false})
    studentNum : string;

    @Column({nullable:true, default:null})
    imagePath : string;

    @Column({type:"float",default:0.0})
    score_1 : number;

    @Column({type:"float",default:0.0})
    score_2 : number;

    @Column({nullable:false,array:true,type:"enum",enum:Interest})
    interest : Interest[]; //이게 배열 가능 ??

    @Column({nullable:false, type:"enum", enum:Department})
    department : Department;

    @Column({type:'enum', enum:Gender,nullable:false})
    gender : Gender;

    @Column({type:'enum',enum:Role, default:Role.NORMAL})
    role : Role;

    @Column({nullable:false})
    birth : Date;

    @Column({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP'})
    createdAt : Date;

    @OneToMany(() => Feed, (feed) => feed.writer, { lazy:true,eager:false})
    feeds: Feed[];

    @OneToMany(()=>Comment,(comment)=>comment.writer,{lazy:true,eager:false})
    comments: Comment[];

    @OneToMany(()=>Club,(club)=>club.leader,{lazy:true,eager:false})
    createdClubs: Club[]

    @OneToMany(()=>Member,(member)=>member.user,{lazy:true,eager:false})
    joinedClubs: Member[]

    @OneToMany(()=>LikeFeed,(likeFeed)=>likeFeed.user,{lazy:true,eager:false})
    likeFeeds:LikeFeed[]

    @OneToMany(()=>Message, (message)=>message.sender,{lazy:true})
    messages : Message[]

    @OneToMany(()=>LikeClub, (likeClub)=>likeClub.user,{lazy:true,eager:false})
    likeClubs : LikeClub[]

}