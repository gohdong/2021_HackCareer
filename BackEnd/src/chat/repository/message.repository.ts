import { User } from "src/auth/model/user.entity";
import { Club } from "src/club/model/club.entity";
import { EntityRepository, Repository } from "typeorm";
import { Message } from "../model/message.entity";

@EntityRepository(Message)
export class MessageRepository extends Repository<Message>{

    saveMessage(user:User,club:Club,content:string){
        const message : Message = this.create({
            sender:user,
            club,
            content
        });

        return this.save(message);
    }
    
}