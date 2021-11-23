import { IsNotEmpty, IsOptional, IsString } from "class-validator";


export class FeedUpdateDTO {
    @IsOptional()
    @IsString()
    description:string;

    @IsOptional()
    @IsString({each:true})
    removedImagePath : string[];

    @IsOptional()
    @IsString({each:true})
    addedImagePath? : string[];
}