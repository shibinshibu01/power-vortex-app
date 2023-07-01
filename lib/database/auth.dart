import 'package:firebase_auth/firebase_auth.dart';
import '../global.dart';

Future signIn(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    currentuser = userCredential.user;
    return 'success';
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      return 'Wrong password provided for that user.';
    }
  }
}

Future signUp(String email, String password, String name) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    
    await userCredential.user!.sendEmailVerification();
    await userCredential.user!.updateDisplayName(name);
    currentuser = userCredential.user;
    return 'success';
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return 'The password provided is too weak.';
    } else if (e.code == 'email-already-in-use') {
      return 'The account already exists for that email.';
    }
  } catch (e) {
    return e.toString();
  }
}
