import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import * as config from 'config'
import { Logger, ValidationPipe } from '@nestjs/common';
import { EntityNotFoundExceptionFilter } from './filter/entity-not-found-exception.filter';


async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.useGlobalPipes(new ValidationPipe())
  app.useGlobalFilters(new EntityNotFoundExceptionFilter());
  
  const serverConfig = config.get('server')
  const port = serverConfig.port;
  await app.listen(port);

  Logger.log(`Application running on port ${port}`)
  Logger.log(`Application running on port ${port}`)
}
bootstrap();
