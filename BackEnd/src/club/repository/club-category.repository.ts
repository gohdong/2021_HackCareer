import { EntityRepository, Repository } from "typeorm";
import { ClubCatecory } from "../model/club-catecory.entity";

@EntityRepository(ClubCatecory)
export class ClubCatecoryRepository extends Repository<ClubCatecory>{

    
}