import { NotFoundException } from "@nestjs/common";
import { title } from "process";
import { User } from "src/auth/model/user.entity";
import { EntityRepository, Repository } from "typeorm";
import { ClubDTO } from "../model/club.dto";
import { Club } from "../model/club.entity";


@EntityRepository(Club)
export class ClubRepository extends Repository<Club>{

    createClub(clubDTO:ClubDTO,user:User):Promise<Club>{
        const {
            title,
            description,
            imagePath,
            timeLimit,
            numLimit,
            isThunder} = clubDTO;

        const club =  Club.create({
            title,
            description,
            imagePath,
            timeLimit,
            numLimit,
            isThunder,
            leader:user
        })
        return this.save(club)
    }

    async findClubById(id:number):Promise<Club>{
        return this.findOneOrFail(id,{
            relations:['leader','members']
        })
    }
}