import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectycube_sdk/connectycube_chat.dart';
import 'package:connectycube_sdk/connectycube_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ownervet/chat/chat_provider.dart';
import 'package:ownervet/drawer/controllers/drawer_controllers.dart';
import 'package:ownervet/routes/app_pages.dart';
import 'package:ownervet/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ownervet/services/firebaseCallback.dart';
import 'package:ownervet/services/local_notifications_services.dart';
import 'package:ownervet/src/managers/call_manager.dart';
import 'package:ownervet/src/managers/push_notifications_manager.dart';
import 'package:ownervet/utils/get_constant.dart';
import 'package:ownervet/utils/pref_util.dart';
import 'package:ownervet/utils/strings.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
var uuid = Uuid();

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //this._currentUuid = uuid.v4();
  print('hiii1223456789009ytt');
  var params = <String, dynamic>{
    'id': uuid.v4(),
    'nameCaller': 'Hien Nguyen',
    'appName': 'Callkit',

    'handle': '0123456789',
    'type': 0,
    'textAccept': 'Accept',
    'textDecline': 'Decline',
    'textMissedCall': 'Missed call',
    'textCallback': 'Call back',
    'duration': 30000,
    'extra': <String, dynamic>{'userId': '1a2b3c4d'},
    'headers': <String, dynamic>{'apiKey': 'Abc@123!', 'platform': 'flutter'},
    'android': <String, dynamic>{
      'isCustomNotification': false,
      'isShowLogo': false,
      'isShowCallback': false,
      'isShowMissedCallNotification': true,
      'ringtonePath': 'system_ringtone_default',
      'backgroundColor': '#0955fa',
      'backgroundUrl': 'https://i.pravatar.cc/500',
      'actionColor': '#4CAF50'
    },
    'ios': <String, dynamic>{
      'iconName': 'CallKitLogo',
      'handleType': 'generic',
      'supportsVideo': true,
      'maximumCallGroups': 2,
      'maximumCallsPerCallGroup': 1,
      'audioSessionMode': 'default',
      'audioSessionActive': true,
      'audioSessionPreferredSampleRate': 44100.0,
      'audioSessionPreferredIOBufferDuration': 0.005,
      'supportsDTMF': true,
      'supportsHolding': true,
      'supportsGrouping': false,
      'supportsUngrouping': false,
      'ringtonePath': 'system_ringtone_default'
    }
  };
  await FlutterCallkitIncoming.showCallkitIncoming(params);


}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey = GetConstant.publish_key;
  await Stripe.instance.applySettings();
  await GetStorage.init();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Get.lazyPut<DrawersController>(
        () => DrawersController(),
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatefulWidget {

  final SharedPreferences prefs;

  MyApp({required this.prefs});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  var userlogin = GetStorage();


  @override
  void initState() {
    super.initState();
    initConnectycube();
    loginConnection();

  }
  loginConnection(){
    if(userlogin.read(GetConstant.id)!=null){
      getUserByLogin("own"+userlogin.read(GetConstant.id).toString())
          .then((cubeUser) {
        CubeUser users=      CubeUser(
          id: cubeUser!.id!,
          login:"own"+ userlogin.read(GetConstant.id).toString(),
          fullName:userlogin.read(GetConstant.name),
          password: "supersecurepwd",
        );
        CubeChatConnection.instance.login(users).then((cubeUser) {
          //Get.offAllNamed(AppRoutes.HOME);
          SharedPrefs.saveNewUser(users);

          PushNotificationsManager.instance.init();


        }).catchError((exception) {
          print(exception);
          //   _processLoginError(exception);
        });});
    }

  }

  initConnectycube(){
    init(
      Strings.APP_ID,
      Strings.AUTH_KEY,
      Strings.AUTH_SECRET,
      onSessionRestore: () {
        return SharedPrefs.getUser().then((savedUser) {
          return createSession(savedUser);
        });
      },
    );
  }// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

    CallManager.instance.init(context);

    return MultiProvider(
      providers: [
        Provider<ChatProvider>(
          create: (_) => ChatProvider(
            prefs: this.widget.prefs,
            firebaseFirestore: this.firebaseFirestore,
            firebaseStorage: this.firebaseStorage,
          ),
        ),
      ],

      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        initialRoute:userlogin.read(GetConstant.token)!=null??false?AppRoutes.HOME: AppRoutes.SPLASH,
        getPages: AppPages.list,
      ),
    );
  }
}


