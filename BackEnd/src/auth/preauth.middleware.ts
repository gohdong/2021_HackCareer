import { Injectable, NestMiddleware } from "@nestjs/common"
import * as serviceAccount from "./firebaseServiceAccount.json"
import * as firebase from 'firebase-admin'
import { Request, Response } from "express"
import { app } from "firebase-admin"

const firebase_params = {
    type: serviceAccount.type,
    projectId: serviceAccount.project_id,
    privateKeyId : serviceAccount.private_key_id,
    privateKey : serviceAccount.private_key,
    clientEmail : serviceAccount.client_email,
    cliendId : serviceAccount.client_id,
    authUri : serviceAccount.auth_uri,
    tokenUri : serviceAccount.token_uri,
    authProviderX509CerUrl: serviceAccount.auth_provider_x509_cert_url,
    clientX509CetUrl:serviceAccount.client_x509_cert_url
}

@Injectable()
export class PreauthMiddleware implements NestMiddleware{

    private defaultApp : app.App;

    constructor(){
        this.defaultApp = firebase.initializeApp({
            credential: firebase.credential.cert(firebase_params),
            
            // databaseURL
        })
    }
    use(req: Request, res: Response, next: () => void) {
        const token = req.headers.authorization;
        if(token != null && token != ''){
            this.defaultApp.auth().verifyIdToken(token.replace("Bearer ",""))
            .then(async decodedToken => {
                //TODO: email인증된 유저만?
                console.log(decodedToken)
                const user = {email:decodedToken.email}
                console.log(user)
                req['user'] = user;
                next()
            }).catch(error =>{
                console.error(error);
                this.accessDenied(req.url,res)
            })
        }else{
            next()
        }
    }

    private accessDenied(url : string, res:Response){
        res.status(403).json({
            statusCode:403,
            timestamps: new Date().toISOString(),
            path:url,
            message: "Access Denied"
        })
    }
}