import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

// FacebookLogin facebookSignIn = new FacebookLogin();

Future<UserCredential> signInWithFacebook() async {
  // Trigger the sign-in flow
  final LoginResult loginResult = await FacebookAuth.instance.login();
  if(loginResult.accessToken==null){
    logoutFb();
  }

  // Create a credential from the access token
  final OAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(loginResult.accessToken!.token);


  // Once signed in, return the UserCredential
  return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
}

// Future<FacebookModel?> fbLogin() async {
//   final result = await facebookSignIn.logIn(['email']);
//   switch (result.status) {
//     case FacebookLoginStatus.loggedIn:
//       // Fluttertoast.showToast(msg: 'User LoggedIn success');
//       final accessToken = result.accessToken.token;
//
//       print("accessToken==== $accessToken");
//       String url =
//           'https://graph.facebook.com/v8.0/me?fields=name,first_name,last_name,email&access_token=$accessToken';
//       var request = new http.MultipartRequest("GET", Uri.parse(url));
//       try {
//         final response = await request.send().timeout(Duration(seconds: 10));
//         final respStr = await response.stream.bytesToString();
//         print("----url---$url");
//         print("----respStr---$respStr");
//         final parseFbData = json.decode(respStr);
//         FacebookModel fbModel = FacebookModel.fromJson(parseFbData);
// //        print("=====profile=====  $parseFbData");
//         return fbModel;
//       } catch (e) {
//         print("----catch---${e.toString()}");
//         //Utils.showToast(e.toString(), true);
//         return null;
//       }
//       break;
//     case FacebookLoginStatus.cancelledByUser:
//       AppUtils.Snackbar(
//           'Error', 'Could not fetch your email. your account is private');
//       break;
//     case FacebookLoginStatus.error:
//       facebookSignIn.logOut();
//
//       AppUtils.Snackbar('Error', "Something went wrong ${result.errorMessage}");
//       break;
//   }
//   return null;
// }

Future<void> logoutFb() async {
  final AccessToken? accessToken = await FacebookAuth.instance.accessToken;
  if (accessToken != null) {
    // user is logged
    await FacebookAuth.instance.logOut();
  }
}
