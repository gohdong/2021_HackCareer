import { BaseEntity, Column, Entity, OneToMany, OneToOne, PrimaryGeneratedColumn } from "typeorm";
import {Feed} from 'src/feed/model/feed.entity';
import { FeedCategoryEnum } from "./feed.enum";

@Entity()
export class FeedCategory extends BaseEntity{

    @PrimaryGeneratedColumn()
    id: number;

    @Column({type:"enum",enum:FeedCategoryEnum})
    categoryTitle : FeedCategoryEnum;

    @OneToMany(()=>Feed,(feed)=>feed.category)
    feeds : Feed[]



}