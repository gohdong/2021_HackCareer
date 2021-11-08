import { Optional } from "@nestjs/common";
import { User } from "src/auth/model/user.entity";
import { BaseEntity, Column, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm";


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

    @ManyToOne(()=>User, (user)=>user.feeds,{eager:true})
    writer:User;

}