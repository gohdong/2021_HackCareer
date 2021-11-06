import { Type } from "class-transformer";
import { IsArray, IsDate, IsEmail, IsEnum, IsNotEmpty, IsOptional, IsString, Length, MaxLength, MinLength, ValidateNested } from "class-validator";
import { Department, Gender, Interest } from "./user.enum";

export class SignupDTO {

    @IsNotEmpty()
    @IsString()
    uid:string;

    @IsNotEmpty()
    @IsEmail()
    email:string;

    @IsNotEmpty()
    @IsString()
    @Length(3,8)
    nickname:string;

    @IsNotEmpty()
    @IsString()
    @Length(10,10)
    studentNum : string;

    @IsOptional()
    @IsEnum(Interest,{each:true})
    interest : Interest[];

    @IsNotEmpty()
    @IsEnum(Department)
    department : Department;

    @IsNotEmpty()
    @IsEnum(Gender)
    gender : Gender;

    @IsDate()
    @Type(() => Date)
    birth : Date;








    
}