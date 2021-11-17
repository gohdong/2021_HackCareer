import { EntityRepository, Repository } from "typeorm";
import { Member } from "../model/member.entity";

@EntityRepository(Member)
export class MemberRepository extends Repository<Member>{

    
}