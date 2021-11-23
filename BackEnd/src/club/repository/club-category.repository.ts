import { EntityRepository, Repository } from "typeorm";
import { ClubCategory } from "../model/club-catecory.entity";

@EntityRepository(ClubCategory)
export class ClubCatecoryRepository extends Repository<ClubCategory>{

    
}