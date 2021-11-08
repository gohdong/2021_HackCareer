import { IsNotEmpty, IsOptional, IsString } from "class-validator";


export class FeedDTO {
    
    @IsString()
    @IsNotEmpty()
    description:string;

    @IsString({each:true})
    imagePath:string[];
}