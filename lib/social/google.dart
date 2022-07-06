
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn googleSignIn = GoogleSignIn();
FirebaseAuth auth = FirebaseAuth.instance;

Future<User?> gSignIn() async {
  await Firebase.initializeApp();
  googleSignIn.signOut();
  final GoogleSignInAccount? _googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
  await _googleSignInAccount!.authentication;

  final AuthCredential userCredentials = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken);
  print("token"+googleSignInAuthentication.accessToken.toString());
  print("tokenId"+googleSignInAuthentication.idToken.toString());

  final UserCredential userCredential =
  await auth.signInWithCredential(userCredentials);
 await auth.currentUser!.getIdToken().then((value) {
   print("AuthToken...."+googleSignInAuthentication.idToken.toString());

 });
  final User? user = userCredential.user;
  if (user != null) {
    assert(user.email != null);
    assert(user.photoURL != null);

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    final User? currentUser = auth.currentUser;
    assert(user.uid == currentUser!.uid);
    print('Signin Succeed');
    print("display Name"+user.displayName.toString());
  }
  return user;
}

Future<void> gSignOut() async {
  await googleSignIn.signOut();
  print('google_sign_out');
}
