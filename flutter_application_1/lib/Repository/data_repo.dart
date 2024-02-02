import 'package:firebase_auth/firebase_auth.dart';

import '../constants/custom_exception.dart';

class DataRepo {
  String? mobileNumber;

  final _auth = FirebaseAuth.instance;
  String? verificationCredentials;

  //verify number and send otp
  Future<bool> verifyNumberAndSendOtp({
    required String number,
  }) async {
    try {
      bool isVerificationCompleted = false;
      _auth.verifyPhoneNumber(
        phoneNumber: "+91$number",
        verificationCompleted: (phoneAuthCredential) async {
          //=> firebase automatically verfied the otp
          await _auth.signInWithCredential(phoneAuthCredential);

          isVerificationCompleted = true;
        },
        verificationFailed: (verificationFailed) {
          throw CustomException(
              msg: verificationFailed.message ??
                  "Failed to Verify Mobile Number. Please Try Again !");
        },
        codeSent: (verificationCredential, forceResendingToken) {
          verificationCredentials = verificationCredential;
        },
        codeAutoRetrievalTimeout: (codeAutoRetrievalTimeout) {},
      );
      return isVerificationCompleted;
    } on FirebaseAuthException catch (e) {
      throw CustomException(msg: e.code);
    } catch (e) {
      rethrow;
    }
  }

//verify the otp already sent
  Future<void> verifyOtp({
    required String number,
    required String otp,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationCredentials!,
        smsCode: otp,
      );
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw CustomException(msg: e.code);
    } catch (e) {
      rethrow;
    }
  }
}
