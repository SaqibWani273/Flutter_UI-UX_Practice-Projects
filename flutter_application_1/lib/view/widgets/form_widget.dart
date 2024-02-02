import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Repository/data_repo.dart';
import '../../view_model/auth_bloc/auth_bloc_bloc.dart';
import '../login_screen.dart';
import 'otp_textformfield.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({super.key});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  bool isOtpForm = false;
  bool _animationCompleted = false;
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      toggleStatus();
    });
  }

  void toggleStatus() {
    setState(() {
      _animationCompleted = !_animationCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Stack(children: [
        AnimatedPositioned(
            duration: Duration(milliseconds: 400),
            curve: Curves.elasticOut,
            right: _animationCompleted
                //center position
                ? MediaQuery.of(context).size.width / 2
                //outside page from left
                : MediaQuery.of(context).size.width + 50,
            child: Container(
                height: 200,
                color: Colors.green,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //if otp is sent, then show otp field else show phone number field
                    isOtpForm
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
                              backgroundColor:
                                  const Color.fromARGB(206, 1, 42, 63)),
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            context.read<DataRepo>().mobileNumber =
                                phoneController.text.trim();
                            context.read<AuthBlocBloc>().add(SignInEvent(
                                number: phoneController.text.trim()));
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
                  ],
                )

                //....
                //  Text(
                //   "${isOtpForm ? 'Enter OTP' : 'Enter Mobile Number'}",
                // ),
                ))
      ]),
    );
  }
}
