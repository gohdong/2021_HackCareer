import * as serviceAccount from "../firebaseServiceAccount.json"

const FirebaseStorage = require('multer-firebase-storage')
const Multer = require('multer')
const path = require('path')

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



type validFileExtension = 'png' | 'jpg' | 'jpeg';
type validMimeType = 'image/png' | 'image/jpg' | 'image/jpeg';

const validFileExtensions: validFileExtension[] = ['jpeg','jpg','png']
const validMimeTypes : validMimeType[] = ['image/jpeg','image/jpg','image/png']

export const saveProfileImageToStorage = Multer({
    storage: FirebaseStorage({
        bucketName: "gs://club-cb0f5.appspot.com",
        directoryPath:"profiles",
        public:true,
        credentials: {
            clientEmail: firebase_params.clientEmail,
            privateKey: firebase_params.privateKey,
            projectId: firebase_params.projectId
        },
        hooks:{
            beforeUpload (req, file) {
                file.originalname = req.user.uid + path.extname(file.originalname) //uid + ext
              },
        }
    }),
    fileFilter: (req,file,cb)=>{
        const allowedMimeTypes:validMimeType[] = validMimeTypes;
        allowedMimeTypes.includes(file.mimetype)? cb(null,true): cb(null,false)
    }
  })