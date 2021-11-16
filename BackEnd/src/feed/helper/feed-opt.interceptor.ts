import { CallHandler, createParamDecorator, ExecutionContext, Injectable, NestInterceptor } from "@nestjs/common";
import { Observable } from "rxjs";




@Injectable()
export class BodyInterceptor implements NestInterceptor {
  intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
    const req = context.switchToHttp().getRequest()
    req.body = JSON.parse(req.body['opt'])
    // return Promise.resolve()
    return next
      .handle()
      .pipe(
        
      );
  }
}