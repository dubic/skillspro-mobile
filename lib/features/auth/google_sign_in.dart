// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email'
    ],
  );

  final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
  // Obtain the auth details from the request
  if (googleUser == null) {
    throw Exception("Google sign in failed");
  }
  print('Google user: $googleUser');



  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  // print('ACCESS tokens...${googleAuth.accessToken}');
  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
