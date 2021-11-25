import { InjectRepository } from "@nestjs/typeorm";
import { EntityRepository, Repository } from "typeorm";
import { LikeClub } from "../model/like-club.entity";

@EntityRepository(LikeClub)
export class LikeClubRepository extends Repository<LikeClub>{

}