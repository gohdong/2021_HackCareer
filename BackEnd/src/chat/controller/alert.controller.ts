import { Body, Controller, HttpCode, Post } from '@nestjs/common';
import { AlertGateway } from '../gateway/alert.gateway';

@Controller('alert')
export class AlertController {
    constructor(
        private alertGateway:AlertGateway,
    ){}

    @Post()
    @HttpCode(200)
    sendAlertToAll(@Body() dto:{message:string}){ //form url enconding
        this.alertGateway.sendToAll(dto.message);
        return dto;
    }
}
