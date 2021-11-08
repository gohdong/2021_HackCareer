import { User } from "src/auth/model/user.entity";
import { BaseEntity, Column, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm";


@Entity()
export class Feed extends BaseEntity{
    @PrimaryGeneratedColumn()
    id:number;

    @Column({nullable:false})
    description:string;

    @Column({nullable:false,array:true})
    imagePath:string[];

    @Column({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP'})
    createdAt : Date;

    @ManyToOne(()=>User, (user)=>user.feeds)
    writer:User;

}