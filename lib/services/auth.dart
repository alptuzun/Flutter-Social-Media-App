import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_group_28/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
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
      } else if (e.code == 'account-exists-with-different-credential') {
        return e.message ??
            "The account already exists with a different credential";
      } else if (e.code == "too-many-requests") {
        return e.message ?? "Too many login attempts, please try again later";
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> registerUserWithEmailPass(
      String email, String pass, String displayName, String username) async {
    try {
      UserCredential uc = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      UserService.registerUser(
          username, displayName, uc.user!.uid, uc.user!.email.toString());
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

  Future signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance
          .login(permissions: (['email', 'public_profile']));
      final token = result.accessToken!.token;
      print(
          'Facebook token userID : ${result.accessToken!.grantedPermissions}');
      final graphResponse = await http.get(Uri.parse(
          'https://graph.facebook.com/'
          'v2.12/me?fields=name,first_name,last_name,email&access_token=$token'));

      final profile = jsonDecode(graphResponse.body);
      print("Profile is equal to $profile");
      try {
        final AuthCredential facebookCredential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        final userCredential = await FirebaseAuth.instance
            .signInWithCredential(facebookCredential);
        User? currUser = userCredential.user;
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('Users')
            .doc(currUser!.uid)
            .get();
        if (!snapshot.exists) {
          String newUserName = "user";
          newUserName +=
              DateTime.now().toUtc().microsecondsSinceEpoch.toString();
          UserService.registerUser(newUserName, profile['name'] ?? "",
              currUser.uid, profile['email']);
        }
        return _userFromFirebase(currUser);
      } catch (e) {
        return e.toString();
      }
    } catch (e) {
      print("error occurred");
      print(e.toString());
    }
  }

  Future<dynamic> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential uc =
        await FirebaseAuth.instance.signInWithCredential(credential);
    User? currUser = uc.user;
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(currUser!.uid)
        .get();
    if (!snapshot.exists) {
      String newUserName = "user";
      newUserName += DateTime.now().toUtc().microsecondsSinceEpoch.toString();
      UserService.registerUser(newUserName, googleUser?.displayName ?? "",
          currUser.uid, googleUser!.email);
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
    } catch (e) {
      return e.toString();
    }
  }

  Future deleteUserAccount() async {
    // use only when there is a current user!
    if (_auth.currentUser != null) {
      //_auth.currentUser;
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(_auth.currentUser!.uid)
          .delete();
      var comments = await FirebaseFirestore.instance
          .collection('Comments')
          .where("userID", isEqualTo: _auth.currentUser!.uid)
          .get();
      for (var comment in comments.docs) {
        comment.reference.delete();
      }
      var posts = await FirebaseFirestore.instance
          .collection('Posts')
          .where("userID", isEqualTo: _auth.currentUser!.uid)
          .get();
      for (var post in posts.docs) {
        var postID = post.reference.id;
        bool postExists = post.data()["mediaURL"] != null;
        if (postExists) {
          FirebaseStorage.instance
              .ref("userPosts/${_auth.currentUser!.uid}/$postID")
              .delete();
        }
        post.reference.delete();
      }
      var follows = await FirebaseFirestore.instance
          .collection('UserFollowsUser')
          .where("follower", isEqualTo: _auth.currentUser!.uid)
          .get();
      for (var follow in follows.docs) {
        follow.reference.delete();
      }
      var followers = await FirebaseFirestore.instance
          .collection('UserFollowsUser')
          .where("followedUser", isEqualTo: _auth.currentUser!.uid)
          .get();
      for (var follower in followers.docs) {
        follower.reference.delete();
      }
      var likes = await FirebaseFirestore.instance
          .collection('UserLikedPost')
          .where("userID", isEqualTo: _auth.currentUser!.uid)
          .get();
      for (var like in likes.docs) {
        like.reference.delete();
      }
      _auth.currentUser!.delete();
      await signOut();
    } else {
      print('could not delete the account..');
    }
  }

  Future deactivateUserAccount() async {
    // use only when there is a current user!
    //todo implementation
  }
}
