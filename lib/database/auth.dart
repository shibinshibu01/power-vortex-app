import 'package:firebase_auth/firebase_auth.dart';
import 'package:powervortex/database/collections.dart';
import 'package:powervortex/obj/objects.dart';
import '../global.dart';
import 'package:firebase_database/firebase_database.dart';

Future signIn(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    currentuser = userCredential.user;
    userdetails = UserDetails(
        uid: currentuser!.uid,
        name: currentuser!.displayName ?? '',
        email: email);
    await getHomeDetails(0);
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
    await userCredential.user!.reload();
    currentuser = FirebaseAuth.instance.currentUser;
    userdetails = UserDetails(uid: currentuser!.uid, name: name, email: email);
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    databaseReference.child('users').child(currentuser!.uid).set({
      'name': name,
      'email': email,
      'homes': [],
    });
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

Future forgetPassword(String email) async {
  await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
}

Future signOut() async {
  try {
    await FirebaseAuth.instance.signOut();
    return 'success';
  } catch (e) {
    return e.toString();
  }
}
