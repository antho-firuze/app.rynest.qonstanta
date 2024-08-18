import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:qonstanta/helpers/result.dart';

import 'package:get/get.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';

const String StackedFirebaseAuthAppleClientIdMissing =
    'apple-client-id-missing';
const String StackedFirebaseAuthAppleRedirectUriMissing =
    'apple-redirect-uri-missing';

/// Wraps the firebase auth functionality into a service
class FirebaseAuthHelper {
  /// An Instance of Logger that can be used to log out what's happening in the service
  final Logger? log = Logger();

  /// The URI to which the authorization redirects. It must include a domain name, and can’t be an IP address or localhost.
  ///
  /// Must be configured at https://developer.apple.com/account/resources/identifiers/list/serviceId
  // final String? _appleRedirectUri;

  /// The developer’s client identifier, as provided by WWDR.
  ///
  /// This is the Identifier value shown on the detail view of the service after opening it from https://developer.apple.com/account/resources/identifiers/list/serviceId
  /// Usually a reverse domain notation like com.example.app.service
  // final String? _appleClientId;

  final firebaseAuth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  String? _pendingEmail;
  AuthCredential? _pendingCredential;

  Future<UserCredential> _signInWithCredential(
    AuthCredential credential,
  ) async {
    return firebaseAuth.signInWithCredential(credential);
  }

  /// Returns the current logged in Firebase User
  User? get currentUser {
    return firebaseAuth.currentUser;
  }

  /// Returns the latest userToken stored in the Firebase Auth lib
  Future<String>? get userToken {
    return firebaseAuth.currentUser?.getIdToken();
  }

  /// Returns true when a user has logged in or signed on this device
  bool get hasUser {
    return firebaseAuth.currentUser != null;
  }

  /// Exposes the authStateChanges functionality.
  Stream<User?> get authStateChanges {
    return firebaseAuth.authStateChanges();
  }

  /// Returns `true` when email has a user registered
  Future<bool> emailExists(String email) async {
    try {
      final signInMethods =
          await firebaseAuth.fetchSignInMethodsForEmail(email);

      return signInMethods.length > 0;
    } on FirebaseAuthException catch (e) {
      return e.code.toLowerCase() == 'invalid-email';
    }
  }

  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount == null) {
        log?.i('Process is canceled by the user');
        return Result.error(
            message: 'Google Sign In has been cancelled by the user');
      }
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final result = await _signInWithCredential(credential);

      // Link the pending credential with the existing account
      if (_pendingCredential != null) {
        await result.user?.linkWithCredential(_pendingCredential!);
        _clearPendingData();
      }

      return Result.success(data: result.user);
    } on FirebaseAuthException catch (e) {
      log?.e(e);
      return Result.error(message: await _handleAccountExists(e));
    } catch (e) {
      log?.e(e);
      return Result.error(message: e.toString());
    }
  }

  // Future<bool> isAppleSignInAvailable() async {
  //   return await SignInWithApple.isAvailable();
  // }

  Future signInWithApple({
    required String? appleRedirectUri,
    required String? appleClientId,
  }) async {
    try {
      if (appleClientId == null) {
        throw FirebaseAuthException(
          message:
              'If you want to use Apple Sign In you have to provide a appleClientId to the FirebaseAuthHelper',
          code: StackedFirebaseAuthAppleClientIdMissing,
        );
      }

      if (appleRedirectUri == null) {
        throw FirebaseAuthException(
          message:
              'If you want to use Apple Sign In you have to provide a appleRedirectUri to the FirebaseAuthHelper',
          code: StackedFirebaseAuthAppleClientIdMissing,
        );
      }

      // To prevent replay attacks with the credential returned from Apple, we
      // include a nonce in the credential request. When signing in in with
      // Firebase, the nonce in the id token returned by Apple, is expected to
      // match the sha256 hash of `rawNonce`.
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      // final appleIdCredential = await SignInWithApple.getAppleIDCredential(
      //   scopes: [
      //     AppleIDAuthorizationScopes.email,
      //     AppleIDAuthorizationScopes.fullName,
      //   ],
      //   webAuthenticationOptions: WebAuthenticationOptions(
      //     clientId: appleClientId,
      //     redirectUri: Uri.parse(appleRedirectUri),
      //   ),
      //   nonce: nonce,
      // );

      // final oAuthProvider = OAuthProvider('apple.com');
      // final credential = oAuthProvider.credential(
      //   idToken: appleIdCredential.identityToken,
      //   accessToken: appleIdCredential.authorizationCode,
      //   rawNonce: rawNonce,
      // );

      // final result = await _signInWithCredential(credential);

      // // Link the pending credential with the existing account
      // if (_pendingCredential != null) {
      //   await result.user?.linkWithCredential(_pendingCredential!);
      //   _clearPendingData();
      // }

      // return Result.success(data: result.user);
    } on FirebaseAuthException catch (e) {
      log?.e(e);
      return Result.error(message: await _handleAccountExists(e));
      // } on SignInWithAppleAuthorizationException catch (e) {
      //     return Result.error(message: e.toString());
    } catch (e) {
      log?.e(e);
      return Result.error(message: e.toString());
    }
  }

  /// Anonymous Login
  Future signInAnonymously() async {
    try {
      log?.d('Anonymoys Login');
      final result = await firebaseAuth.signInAnonymously();

      return Result.success(data: result.user);
    } on FirebaseAuthException catch (e) {
      log?.e('A firebase exception has occured. $e');
      return Result.error(message: getErrorMessageFromFirebaseException(e));
    } on Exception catch (e) {
      log?.e('A general exception has occured. $e');
      return Result.error(message: 'error_firebase_login'.tr);
    }
  }

  Future signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      log?.d('email:$email');
      final result = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      log?.d(result.user);
      // log?.d('Sign in with email result: ${result.credential} ${result.user}');

      // Link the pending credential with the existing account
      if (_pendingCredential != null) {
        await result.user?.linkWithCredential(_pendingCredential!);
        _clearPendingData();
      }

      return Result.success(data: result.user);
    } on FirebaseAuthException catch (e) {
      log?.e('A firebase exception has occured. $e');
      return Result.error(
          message: getErrorMessageFromFirebaseException(e), errCode: e.code);
    } on Exception catch (e) {
      log?.e('A general exception has occured. $e');
      return Result.error(message: 'error_firebase_login'.tr);
    }
  }

  /// Uses `createUserWithEmailAndPassword` to sign up to the Firebase application
  Future signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      log?.d('email:$email');
      final result = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      log?.d(
          'Create user with email result: ${result.credential} ${result.user}');

      return Result.success(data: result.user);
    } on FirebaseAuthException catch (e) {
      log?.e('A firebase exception has occured. $e');
      return Result.error(message: getErrorMessageFromFirebaseException(e));
    } on Exception catch (e) {
      log?.e('A general exception has occured. $e');
      return Result.error(message: 'error_firebase_login'.tr);
    }
  }

  Future _handleAccountExists(FirebaseAuthException e) async {
    if (e.code != 'account-exists-with-different-credential') {
      return Result.error(message: e.toString());
    }

    // The account already exists with a different credential
    _pendingEmail = e.email;
    _pendingCredential = e.credential;

    // Fetch a list of what sign-in methods exist for the conflicting user
    List<String> userSignInMethods =
        await firebaseAuth.fetchSignInMethodsForEmail(_pendingEmail ?? '');

    // If the user has several sign-in methods,
    // the first method in the list will be the "recommended" method to use.

    // Check if the recommended account is email then tell them to sign up with email
    if (userSignInMethods.first == 'password') {
      return Result.error(
        message:
            // 'We don’t have the ability to merge social accounts with existing Delivery Dudes accounts. Log in using the same email as this social platform.',
            'To link your Facebook account with your existing account, please sign in with your email address and password.',
      );
    }

    if (userSignInMethods.first == 'google.com') {
      return Result.error(
        message:
            'We could not log into your account but we noticed you have a Google account with the same details. Please try to login with Google.',
      );
    }

    if (userSignInMethods.first == 'apple') {
      return Result.error(
        message:
            'We could not log into your account but we noticed you have a Apple account with the same details. Please try to login with your Apple account instead.',
      );
    }

    // This is here to ensure if we ever get into this function we HAVE to give the user feedback on this error. So we use the sign In methods recommended account
    // and the throw the user an exception.
    return Result.error(
      message:
          'We could not log into your account but we noticed you have a ${userSignInMethods.first} account with the same details. Please try to login with that instead.',
    );
  }

  /// Sign out of the social accounts that have been used
  Future signOut() async {
    log?.i('signOut');

    try {
      await firebaseAuth.signOut();
      // await _googleSignIn.signOut();
      _clearPendingData();
      return Result.success();
    } catch (e) {
      log?.e('Could not sign out of social account. $e');
      return Result.error();
    }
  }

  void _clearPendingData() {
    _pendingEmail = null;
    _pendingCredential = null;
  }

  /// Send reset password link to email
  Future sendResetPasswordLink(String email) async {
    log?.i('email:$email');

    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      log?.e('Could not send email with reset password link. $e');
      return false;
    }
  }

  /// Validate the current [password] of the Firebase User
  Future validatePassword(String password) async {
    try {
      final authCredentials = EmailAuthProvider.credential(
        email: firebaseAuth.currentUser?.email ?? '',
        password: password,
      );

      final result = await firebaseAuth.currentUser
          ?.reauthenticateWithCredential(authCredentials);

      return Result.success(data: result?.user);
    } catch (e) {
      log?.e('Could not validate the user password. $e');
      return Result.error(message: 'error_validate_password'.tr);
    }
  }

  /// Update the [password] of the Firebase User
  Future updatePassword(String password) async {
    await firebaseAuth.currentUser?.updatePassword(password);
  }

  /// Update the [email] of the Firebase User
  Future updateEmail(String email) async {
    await firebaseAuth.currentUser?.updateEmail(email);
  }

  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}

String getErrorMessageFromFirebaseException(FirebaseAuthException exception) {
  switch (exception.code.toLowerCase()) {
    case 'email-already-in-use':
      return 'error_firebase_email-already-in-use'.tr;
    case 'invalid-email':
      return 'error_firebase_invalid-email'.tr;
    case 'operation-not-allowed':
      return 'error_firebase_operation-not-allowed'.tr;
    case 'weak-password':
      return 'error_firebase_weak-password'.tr;
    case 'wrong-password':
      return 'error_firebase_wrong-password'.tr;
    case 'network-request-failed':
      return 'error_firebase_network-request-failed'.tr;
    default:
      return exception.message ?? 'error_firebase_default'.tr;
  }
}

final firebaseAuthHelper = FirebaseAuthHelper();
