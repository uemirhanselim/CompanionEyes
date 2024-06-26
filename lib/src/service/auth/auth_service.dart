import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companioneyes/src/local/local_storage.dart';
import 'package:companioneyes/src/model/auth/new_user.dart';
import 'package:companioneyes/src/service/error/auth_exception_handler.dart';
import 'package:companioneyes/src/utils/local_storage_keys.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<AuthStatus> passwordResetEmailSend({required String email}) async {
    AuthStatus status = AuthStatus.unknown;

    await _auth
        .sendPasswordResetEmail(email: email)
        .then((value) => status = AuthStatus.successful)
        .catchError(
            (e) => status = AuthExceptionHandler.handleAuthException(e));

    return status;
  }

  Future<AuthStatus> login({
    required String email,
    required String password,
  }) async {
    AuthStatus status = AuthStatus.unknown;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      await LocalStorageService.instance.setString(
        LocalStorageKeys.userCredential,
        userCredential.user!.uid,
      );
      status = AuthStatus.successful;
    } on FirebaseAuthException catch (e) {
      status = AuthExceptionHandler.handleAuthException(e);
    }
    return status;
  }

  Future<AuthStatus> createAccount({
    required NewUser newUser,
  }) async {
    AuthStatus status = AuthStatus.unknown;
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: newUser.email,
        password: newUser.password,
      );
      await LocalStorageService.instance.setString(
        LocalStorageKeys.userCredential,
        userCredential.user!.uid,
      );
      print("goes here");
      String userType = newUser.isVolunteer ? 'volunteer' : 'visuallyImpaired';
      await FirebaseFirestore.instance
          .collection(userType)
          .doc(userCredential.user!.uid)
          .set({
        'firstName': newUser.firstName,
        'lastName': newUser.lastName,
        'email': newUser.email,
        'gender': newUser.gender,
        'language': newUser.language,
        'fcmToken': newUser.fcmToken,
        'status': newUser.status.toString().split('.').last,
      });

      status = AuthStatus.successful;
    } on FirebaseAuthException catch (e) {
      status = AuthExceptionHandler.handleAuthException(e);
      print("Hata" + e.toString());
    }
    return status;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
