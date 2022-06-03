import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_group_28/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _userFromFirebase(User? user) {
    return user;
  }

  Stream<User?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  Future<dynamic> signInWithEmailPass(String email, String pass) async {
    try {
      UserCredential uc = await _auth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      return _userFromFirebase(uc.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return e.message ?? 'E-mail and/or Password not found';
      } else if (e.code == 'wrong-password') {
        return e.message ?? 'Password is not correct';
      }
      else if (e.code == 'account-exists-with-different-credential') {
        return e.message ?? "The account already exists with a different credential";
      }
      else if (e.code == "too-many-requests") {
        return e.message ?? "Too many login attempts, please try again later";
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> registerUserWithEmailPass(String email, String pass, String displayName, String username) async {
    try {
      UserCredential uc = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      UserService.registerUser(username, displayName, uc.user!.uid, uc.user!.email.toString());
      return _userFromFirebase(uc.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return e.message ?? 'E-mail already in use';
      } else if (e.code == 'weak-password') {
        return e.message ?? 'Your password is weak';
      }
    }
  }

  Future<dynamic> signInAnon() async {
    try {
      UserCredential uc = await _auth.signInAnonymously();
      return uc.user;
    } on FirebaseAuthException catch (e) {
      return e.message ?? 'Cannot sign in anonymously';
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential uc =
        await FirebaseAuth.instance.signInWithCredential(credential);
    User? currUser = uc.user;
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('Users').doc(currUser!.uid).get();
    if (!snapshot.exists){
      String newUserName = "user";
      newUserName += DateTime.now().toUtc().microsecondsSinceEpoch.toString();
      UserService.registerUser(newUserName, googleUser?.displayName ?? "", currUser.uid, googleUser!.email);
    }
    return _userFromFirebase(uc.user);
  }

  Future signOut() async {
    await _auth.signOut();
  }

  Future passwordResetEmail(String mail) async {
    try {
      await _auth.sendPasswordResetEmail(email: mail);
    } on FirebaseAuthException catch (e) {
      return e.message ?? "Cannot send reset email to reset password";
    }
      catch (e) {
        return e.toString();
    }
  }
}
