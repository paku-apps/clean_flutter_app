//Path Server
//https://z1groinscc.execute-api.us-east-1.amazonaws.com
//const String pathServer = "https://z1groinscc.execute-api.us-east-1.amazonaws.com/";
//const String pathServer = "https://5ceizgcy8c.execute-api.us-east-1.amazonaws.com/";

const String pathServer = "https://87478vb3rk.execute-api.us-east-1.amazonaws.com/";
//const String pathServer = "https://hxnr814yad.execute-api.us-east-1.amazonaws.com/";
 
//const String pathServer = "http://10.0.2.2:9000/";

const String cognitoPath = "https://auth-cvm-tst.auth.us-east-1.amazoncognito.com/oauth2/token";
const String cognitoIdClient = "64ca1iq3m7c9ivs9tq2hlk5ss3";


//Path Enviroment
const String stage = "tst";
//const String stage = "prd";

//PathServices
//Auth
const String loginService = "/login";

//Father
const String childrenService = "/apoderados/:1/estudiantes";
const String childrenAssignService = "/apoderados/:1/hijos";
const String qrPrincipalService = "/qr/apoderado/:1";
const String listAssignService = "/apoderados/:1/autorizaciones";

//Charger
const String searchChargerService = "/responsables/busqueda";

//Assigns
const String createNewAssignService = "/autorizaciones";
const String updateAssignService = "/autorizaciones/:1";
const String deleteAssignService = "/autorizaciones/";

//Charger
const String registerCharger = "/responsables";
const String listAssignChildToday = "/responsables/:1/estudiantes/hoy";
const String listAssignChildFuture = "/responsables/:1/estudiantes/futuro";
const String generateQRDetail = "/qr/responsable/:1";
const String pathDecodeQR = "/qr/descifrar";
const String registerAuthCharger = "/recojos";

//Forgot Pasword
const String submitPathNewPassword = "/usuarios/:1/password";
const String submitPasswordToEmail = "/password/reseteo";