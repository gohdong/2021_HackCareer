import { EntityRepository, Repository } from "typeorm";
import { Message } from "../model/message.entity";

@EntityRepository(Message)
export class MessageRepository extends Repository<Message>{
    
}