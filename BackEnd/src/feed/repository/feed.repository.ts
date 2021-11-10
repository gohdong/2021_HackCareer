import { User } from "src/auth/model/user.entity";
import { EntityRepository, Repository, UpdateResult } from "typeorm";
import { Feed } from "../model/feed.entity";
import { FeedDTO } from "../model/feed.dto";
import { NotFoundException } from "@nestjs/common";

@EntityRepository(Feed)
export class FeedRepository extends Repository<Feed>{

    async findById(id:number):Promise<Feed>{
        const feed:Feed  = await this.findOne(id,{
            loadEagerRelations:false,
            loadRelationIds:{
                relations:["writer"],
                disableMixedMap:true
            }
        })
        if(!feed){
            throw new NotFoundException(`Not Found Feed with id : ${id}`)
        }
        return feed;
    }

    async findOneByIdWithComment(id:number):Promise<Feed>{
        const feed:Feed = await this.findOne(id,{
            loadRelationIds:{
                relations:['comments']
            }
        })
        if(!feed){
            throw new NotFoundException(`Not Found Feed with id : ${id}`)
        }
        return feed
    }

    async writeFeed(user:User,feedDTO:FeedDTO):Promise<Feed>{
        const {description,imagePath} = feedDTO;

        const feed:Feed = this.create({
            writer:user,
            description,
            imagePath
        })
        return await this.save(feed);
    }

    async updateFeed(id:number,feedDTO:FeedDTO):Promise<UpdateResult>{
        const {description,imagePath} = feedDTO;
        const feed : Feed = await this.findById(id);
        feed.description = description;
        feed.imagePath = imagePath;
        return this.update(id,feed);
    }
    
}