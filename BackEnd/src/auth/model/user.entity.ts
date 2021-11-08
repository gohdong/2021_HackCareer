import { Feed } from 'src/feed/model/feed.entity';
import {BaseEntity, Column, CreateDateColumn, Entity, OneToMany, PrimaryColumn, PrimaryGeneratedColumn, Unique} from 'typeorm'
import { Department, Gender, Interest, Role } from './user.enum';
import {Comment} from '../../feed/model/comment.entity'



@Entity()
@Unique(['uid','email'])
export class User extends BaseEntity{
    @PrimaryGeneratedColumn()
    id: number;
    
    @Column({nullable:false})
    uid: string;

    @Column({nullable:false})
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

    @OneToMany(() => Feed, (feed) => feed.writer, { eager: false })
    feeds: Feed[];

    @OneToMany(()=>Comment,(comment)=>comment.writer,{eager:false})
    comments: Comment[];

}