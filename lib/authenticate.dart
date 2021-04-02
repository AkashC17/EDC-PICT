import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:edc_pict/user.dart';


class Auth
{

  String error = " ";
  auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  Users _userFromFirebase(auth.User user){
    return user!=null ? Users(uid: user.uid) : null;
  }

  Stream<Users> get user{
    return _auth.authStateChanges()
        .map(_userFromFirebase);
  }
  Future signOut() async{
    return await _auth.signOut();
  }

  Future registerWithEmailAndPassword(String email,String password)async {
    try {
      auth.UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      auth.User user = result.user;
      // await Database(uid: user.uid).updateDatabase('0','new crew member',10);
        return _userFromFirebase(user);
    }
    on auth.FirebaseAuthException catch(e){
      print(e.code);
      switch (e.code) {
        case "invalid-email":
          error = "Invalid Email";
          break;
        case "wrong-password":
          error = "Incorrect Password";
          break;
        case "user-not-found":
          error = "User not found";
          break;
        case "user-disabled":
          error = "User disabled";
          break;
        case "too-many-requests":
          error = "Too many requests";
          break;
        case "operation-not-allowed":
          error = "Operation not allowed";
          break;
        case "email-already-in-use":
          error = "Email already in use";
          break;
        default:
          error = "Undefined error occured";
      }
      return error;
    }
  }

  Future emailVerification()async
  {
    auth.User user = _auth.currentUser;
    await user.sendEmailVerification();
  }




  Future signInWithEmailAndPassword(String email,String password)async {
    try {
      auth.UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      auth.User user = result.user;
      return _userFromFirebase(user);
    }
    on auth.FirebaseAuthException catch(e){
      print(e.code);
      switch (e.code) {
        case "invalid-email":
          error = "Invalid Email";
          break;
        case "wrong-password":
          error = "Incorrect Password";
          break;
        case "user-not-found":
          error = "User not found";
          break;
        case "user-disabled":
          error = "User disabled";
          break;
        case "too-many-requests":
          error = "Too many requests";
          break;
        case "operation-not-allowed":
          error = "Operation not allowed";
          break;
        case "email-already-in-use":
          error = "Email already in use";
          break;
        default:
          error = "Undefined error occured";
      }
      return error;
    }
  }



}
