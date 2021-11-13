import { IsBoolean, IsDate, IsDateString, IsNumber, IsOptional, IsString } from "class-validator";


export class ClubDTO{

    @IsString()
    title:string;

    @IsString()
    description:string;

    @IsString()
    @IsOptional()
    imagePath:string;

    @IsDateString()
    timeLimit:Date;

    @IsNumber()
    numLimit:number;

    @IsBoolean()
    isThunder:boolean;
}