import { IsNotEmpty, IsOptional, IsString } from "class-validator";


export class UpdateFeedDTO {
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