import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import * as config from 'config'
import { Logger, ValidationPipe } from '@nestjs/common';
import { EntityNotFoundExceptionFilter, QueryFailedExceptionFilter } from './filter/entity-not-found-exception.filter';
import * as fs from 'fs';


// const httpsOptions = {
//   key: fs.readFileSync('./ssl/https.key','utf-8'),
//   cert: fs.readFileSync('./ssl/https.crt','utf-8'),
// };

async function bootstrap() {
  const app = await NestFactory.create(AppModule,{
    // httpsOptions
  });
  app.useGlobalPipes(new ValidationPipe())
  app.useGlobalFilters(new EntityNotFoundExceptionFilter(),new QueryFailedExceptionFilter());
  
  const serverConfig = config.get('server')
  const port = serverConfig.port;
  await app.listen(port);

  Logger.log(`Application running on port ${port}`)
  Logger.log(`Application running on port ${port}`)
}
bootstrap();
