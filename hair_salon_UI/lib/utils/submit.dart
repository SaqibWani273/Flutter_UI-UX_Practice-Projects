import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_practice/models/user_auth_model.dart';
import 'package:ui_practice/view_model/auht_data_provider.dart';

//to do : later get these details manually from user
//add image to this location at firebase storage and get url :
//Build_With_Innovation/user_pic/user_id_from_firebase_auth/
const username = "Saqib Wani";
const imageUrl =
    'https://firebasestorage.googleapis.com/v0/b/practice-a07be.appspot.com/o/Build_With_Innovation%2Fuser_pic%2Fdummy_id_123%2F2150771113.jpg?alt=media&token=742cc0bd-b5d4-4272-9ae2-f254eed53a06';

Future<void> submit({
  required BuildContext context,
  required String number,
  String? otp,
  required final WidgetRef ref,
}) async {
  log(' number is $number');
  final auth = FirebaseAuth.instance;
  final authNotifier = ref.read(authDataProvider.notifier);
  if (otp == null) {
    //to send otp
    auth.verifyPhoneNumber(
      //to do: add country code selector later
      phoneNumber: "+91$number",
      verificationCompleted: (phoneAuthCredential) async {
        //to stop loading indicator
        authNotifier.isLoading = false;
        auth.signInWithCredential(phoneAuthCredential);
        //to finally store userdata at firestore
        try {
          await authNotifier.addUser(UserModel.fromMap({
            'username': username,
            'image': imageUrl,
            'phone': number,
            'id': auth.currentUser!.uid
          }));
        } catch (e) {
          log('error in adding user to firestore');
          showError(ctx: context, msg: 'Error occurred!, user data not added');
        }
      },
      verificationFailed: (error) {
        showError(ctx: context, msg: error.code);
        authNotifier.isLoading = false;
      },
      codeSent: (verificationId, forceResendingToken) {
        authNotifier.verficationId = verificationId;
        //to change page to otp page
        authNotifier.otpSent = true;
        //to stop loading indicator
        authNotifier.isLoading = false;
      },
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  } else {
    //to verify otp
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: ref.read(authDataProvider).verficationId!,
        smsCode: otp,
      );
      //to stop loading indicator

      authNotifier.isLoading = false;
      auth.signInWithCredential(credential);

      await authNotifier.addUser(UserModel.fromMap({
        'username': username,
        'image': imageUrl,
        'phone': number,
        'id': auth.currentUser!.uid
      }));

      log('error in adding user to firestore');
      if (context.mounted) {
        showError(ctx: context, msg: 'Error occurred!, user data not added');
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        showError(
          ctx: context,
          msg: e.code,
        );
      }
      authNotifier.isLoading = false;
    } catch (e) {
      if (context.mounted) {
        showError(ctx: context, msg: 'Error occurred!, user data not added');
      }
    }
  }
}

//for showing any kind of error with a simple error message
void showError({required BuildContext ctx, required String msg}) {
  final errorDialog = ErrorDialog(errorMessage: msg);

  showDialog(
    context: ctx,
    builder: (_) => errorDialog,
    barrierDismissible: false,
  );
}

//error dialog
class ErrorDialog extends ConsumerWidget {
  final String errorMessage;

  const ErrorDialog({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('Error'),
      content: Text(errorMessage),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
