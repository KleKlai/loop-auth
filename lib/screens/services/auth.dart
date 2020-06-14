import 'package:firebase_auth/firebase_auth.dart';
import 'package:loopAuth/models/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance; // Connect to Firebase Auth

  // create user obj based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // Auth change user stream: Listener
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  //TODO: create user obj based on FirebaseUser

  //TODO: Auth Change user stream: Listener

  //TODO: Sign in with Mobile Phone

  //TODO: Sign out
  Future signOut() async {
    try{

      return await _auth.signOut();

    }catch (e) {
      print('Error: ${e.toString()}');
    }
  }
}