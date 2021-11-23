import { IsBoolean, IsDate, IsDateString, IsEnum, IsNumber, IsOptional, IsString } from "class-validator";
import { ClubCategoryEnum } from "./club.enum";


export class ClubUpdateDTO{

    @IsString()
    title:string;

    @IsString()
    description:string;

    // @IsString()
    // @IsOptional()
    // imagePath:string;

    @IsOptional()
    @IsString()
    newImagePath? : string;

    @IsEnum(ClubCategoryEnum)
    category:ClubCategoryEnum;

    @IsDateString()
    timeLimit:Date;

    @IsNumber()
    numLimit:number;

    @IsBoolean()
    isThunder:boolean;
}