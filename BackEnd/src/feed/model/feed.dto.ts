import { IsEnum, IsNotEmpty, IsOptional, IsString } from "class-validator";
import { FeedCategoryEnum } from "./feed.enum";


export class FeedDTO {
    
    @IsString()
    @IsNotEmpty()
    description:string;

    @IsOptional()
    @IsString({each:true})
    imagePath:string[];

    @IsNotEmpty()
    @IsEnum(FeedCategoryEnum)
    category : FeedCategoryEnum;

}