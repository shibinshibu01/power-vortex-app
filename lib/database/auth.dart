import 'package:flutter/material.dart';
import 'package:powervortex/database/collections.dart';
import 'package:powervortex/obj/objects.dart';
import '../global.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';



Future signIn(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    if (!userCredential.user!.emailVerified) {
      return 'Email not verified';
    } else {
      currentuser = userCredential.user;
      userdetails = UserDetails(
          uid: currentuser!.uid,
          name: currentuser!.displayName ?? '',
          email: email);
      await getAllHomes();
      if (currentuser!.photoURL == null) {
        image = Image.asset('assets/user.png');
      } else {
        image = Image.network(
          currentuser!.photoURL!,
          fit: BoxFit.cover,
          height: 150,
          width: 150,
        );
      }

      return 'success';
    }
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

Future sentVerification() async {
  await FirebaseAuth.instance.currentUser!.sendEmailVerification();
}

Future signOut() async {
  try {
    await FirebaseAuth.instance.signOut();
    return 'success';
  } catch (e) {
    return e.toString();
  }
}

Future updateProfilePic(String path) async {
  try {
    // Create a unique filename for the image using the current timestamp

    // Reference to the Firebase Storage bucket and child path
    final Reference ref =
        FirebaseStorage.instance.ref().child('profilepics/${currentuser!.uid}');

    // Upload the file to Firebase Storage
    await ref.putFile(File(path));

    // Get the download URL of the uploaded image
    String downloadURL = await ref.getDownloadURL();
    await currentuser!.updatePhotoURL(downloadURL);
    await currentuser!.reload();
    print('Image uploaded. Download URL: $downloadURL');
  } catch (e) {
    print('Error uploading image: $e');
  }
}
