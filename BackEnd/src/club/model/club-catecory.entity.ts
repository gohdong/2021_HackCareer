import { BaseEntity, Column, Entity, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { Club } from "./club.entity";
import { ClubCategoryEnum } from "./club.enum";


@Entity()
export class ClubCategory extends BaseEntity{

    @PrimaryGeneratedColumn()
    id:number;

    @Column({type:'enum',enum:ClubCategoryEnum})
    categoryTitle:ClubCategoryEnum;

    @OneToMany(()=>Club,(club)=>club.category)
    clubs : Club[]
}