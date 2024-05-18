// this method is for Google sign in.
//First of all you need to add SHA certificate fingerprints to firebase console.
//I didn't implement Google sign in method to this project

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authservice {
  //Google sign in

  signInWithGoogle() async {
    //begin interaction sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    //obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    //create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    //finnaly, let's sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
