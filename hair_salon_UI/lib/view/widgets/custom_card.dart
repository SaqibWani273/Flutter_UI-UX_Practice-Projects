import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_practice/models/user_auth_model.dart';
import 'package:ui_practice/view_model/auht_data_provider.dart';

import '../../../constants/login_page_consts.dart';
import '../../utils/submit.dart';
import 'otp_textformfield.dart';

class CustomCard extends ConsumerStatefulWidget {
  const CustomCard({super.key});

  @override
  ConsumerState<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends ConsumerState<CustomCard> {
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  late UserAuthModel _authRef;
  late AuthDataProvider _authNotifier;

  @override
  void initState() {
    super.initState();

    _authNotifier = ref.read(authDataProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    _authRef = ref.watch(authDataProvider);
    log("rebuild login card");
    return Stack(
      children: [
        Container(
          //  height: double.infinity,
          width: double.infinity,
          margin: const EdgeInsets.only(top: 15),
          child: Card(
            shape: getRoundRectangleBorder(20),
            elevation: 5,
            margin:
                const EdgeInsets.only(left: 20, right: 20, top: 22, bottom: 10),
            child: Center(
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              _authRef.otpSent!
                  ? const OtpTextFormField()
                  : Form(
                      key: _formKey,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null ||
                              value.trim().length != 10 ||
                              int.tryParse(value) == null) {
                            return 'enter valid 10-digit number';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: 'Enter Mobile Number',
                            suffixIcon: Icon(Icons.phone)),
                      ),
                    ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: getRoundRectangleBorder(8.0),
                        minimumSize: const Size(double.infinity, 35),
                        backgroundColor: const Color.fromARGB(206, 1, 42, 63)),
                    onPressed: _authRef.isLoading!
                        ? null
                        : () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }

                            _authNotifier.isLoading = true;
                            _authNotifier.number = phoneController.text.trim();
                            submit(
                              context: context,
                              number: phoneController.text.trim(),
                              ref: ref,
                            );
                          },
                    child: const Text("CONTINUE")),
              ),
              const SizedBox(height: 05),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                  top: 8.0,
                  bottom: 20,
                ),
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      const TextSpan(
                        text: 'By continuing you agree to our \n',
                        style: defaultStyle,
                      ),
                      TextSpan(
                          text: 'Terms & Conditions',
                          style: linkStyle,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              //to do: navigate to terms and conditions
                            }),
                      const TextSpan(
                        text: ' and ',
                        style: defaultStyle,
                      ),
                      TextSpan(
                          text: 'Privacy Policy',
                          style: linkStyle,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              //
                            }),
                    ])),
              )
            ])),
          ),
        ),
        //icon at top center of card
        Align(
            alignment: Alignment.topCenter,
            child: Card(
              elevation: 3,
              shadowColor: Colors.white,
              shape: getRoundRectangleBorder(50),
              child: Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: Icon(
                    _authRef.otpSent!
                        ? Icons.lock_outline_rounded
                        : Icons.lock_outlined,
                    size: 40,
                  ),
                ),
              ),
            ))
      ],
    );
  }
}
///
