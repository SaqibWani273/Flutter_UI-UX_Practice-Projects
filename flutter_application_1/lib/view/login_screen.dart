import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Repository/data_repo.dart';
import 'package:flutter_application_1/view_model/auth_bloc/auth_bloc_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/form_widget.dart';
import 'widgets/otp_textformfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // bool isOtpForm = false;

  @override
  void initState() {
    super.initState();
  }

  final paddingTop = 25.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            //  height: MediaQuery.of(context).size.height - paddingTop,
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height - paddingTop,
                child: Padding(
                  padding: EdgeInsets.only(top: paddingTop),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Expanded(
                      flex: 4,
                      child: Center(
                        child: Image.asset(
                          'assets/images/dummy_logo.jpg',
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                    //main container of the form
                    Expanded(
                      flex: 5,
                      child: Stack(
                        children: [
                          Container(
                            //  height: double.infinity,
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 15),
                            child: Card(
                              shape: getRoundRectangleBorder(20),
                              elevation: 5,
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 22, bottom: 10),
                              child: FormWidget(),
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
                                  child: const Center(
                                    child: Icon(
                                      Icons.lock_outline_rounded,
                                      size: 40,
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    )
                  ]),
                ),
              ),
            ),
          ),
          // if (authRef.isLoading!) const LoadingOverlay(),
        ],
      ),
    );
  }
}

const linkStyle = TextStyle(
  color: Colors.blue,
);
const defaultStyle = TextStyle(color: Colors.black);
RoundedRectangleBorder getRoundRectangleBorder(double radius) {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(radius),
  );
}

class FormWidget extends StatefulWidget {
  // final bool isOtpForm;

  const FormWidget({
    super.key,
  });

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget>
    with SingleTickerProviderStateMixin {
  bool isOtpForm = false;
  bool _animationCompleted = false;
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  // late final AnimationController animationController =
  //     AnimationController(duration: Duration(seconds: 4), vsync: this)
  //       ..repeat();
  // late final Animation<Offset> offsetAnimation =
  //     Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(0.0, 1.5)).animate(
  //         CurvedAnimation(
  //             parent: animationController, curve: Curves.elasticIn));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _start();
    });
  }

  void _start() {
    setState(() {
      _animationCompleted = true;
    });
  }

  @override
  void dispose() {
    // animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var container = Container(
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
                      backgroundColor: const Color.fromARGB(206, 1, 42, 63)),
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    context.read<DataRepo>().mobileNumber =
                        phoneController.text.trim();
                    context
                        .read<AuthBlocBloc>()
                        .add(SignInEvent(number: phoneController.text.trim()));
                    // _authNotifier.isLoading = true;
                    // _authNotifier.number = phoneController.text.trim();
                    // submit(
                    //   context: context,
                    //   number: phoneController.text.trim(),
                    //   ref: ref,
                    // );
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
        );
    return Container(
      height: 200,
      child: Stack(children: [
        AnimatedPositioned(
          duration: Duration(seconds: 1),
          curve: Curves.elasticOut,
          right: _animationCompleted
              //center position
              ? MediaQuery.of(context).size.width / 2
              //outside page from left
              : MediaQuery.of(context).size.width + 50,
          child: container,
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: TextButton(
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                const Size(100, 50),
              )),
              child: Text("Back"),
              onPressed: () {
                setState(() {
                  _animationCompleted = false;
                  isOtpForm = !isOtpForm;
                });
                Future.delayed(Duration(milliseconds: 200), () {
                  setState(() {
                    _animationCompleted = true;
                    // isOtpForm = !isOtpForm;
                  });
                });
              },
            ))
      ]),
    );
    // Column(
    //                               mainAxisAlignment: MainAxisAlignment.end,
    //                               children: [
    //                                 //if otp is sent, then show otp field else show phone number field
    //                                 context
    //                                             .read<DataRepo>()
    //                                             .verificationCredentials ==
    //                                         null
    //                                     ? const OtpTextFormField()
    //                                     : Form(
    //                                         key: _formKey,
    //                                         child: TextFormField(
    //                                           textAlign: TextAlign.center,
    //                                           controller: phoneController,
    //                                           keyboardType:
    //                                               TextInputType.number,
    //                                           validator: (value) {
    //                                             if (value == null ||
    //                                                 value.trim().length != 10 ||
    //                                                 int.tryParse(value) ==
    //                                                     null) {
    //                                               return 'enter valid 10-digit number';
    //                                             }
    //                                             return null;
    //                                           },
    //                                           decoration: const InputDecoration(
    //                                               border:
    //                                                   UnderlineInputBorder(),
    //                                               hintText:
    //                                                   'Enter Mobile Number',
    //                                               suffixIcon:
    //                                                   Icon(Icons.phone)),
    //                                         ),
    //                                       ),
    //                                 const SizedBox(
    //                                   height: 30,
    //                                 ),
    //                                 Padding(
    //                                   padding: const EdgeInsets.symmetric(
    //                                       horizontal: 8.0),
    //                                   child: ElevatedButton(
    //                                       style: ElevatedButton.styleFrom(
    //                                           shape:
    //                                               getRoundRectangleBorder(8.0),
    //                                           minimumSize: const Size(
    //                                               double.infinity, 35),
    //                                           backgroundColor:
    //                                               const Color.fromARGB(
    //                                                   206, 1, 42, 63)),
    //                                       onPressed: () {
    //                                         if (!_formKey.currentState!
    //                                             .validate()) {
    //                                           return;
    //                                         }
    //                                         context
    //                                                 .read<DataRepo>()
    //                                                 .mobileNumber =
    //                                             phoneController.text.trim();
    //                                         context.read<AuthBlocBloc>().add(
    //                                             SignInEvent(
    //                                                 number: phoneController.text
    //                                                     .trim()));
    //                                         // _authNotifier.isLoading = true;
    //                                         // _authNotifier.number = phoneController.text.trim();
    //                                         // submit(
    //                                         //   context: context,
    //                                         //   number: phoneController.text.trim(),
    //                                         //   ref: ref,
    //                                         // );
    //                                       },
    //                                       child: const Text("CONTINUE")),
    //                                 ),
    //                                 const SizedBox(height: 05),
    //                                 Padding(
    //                                   padding: const EdgeInsets.only(
    //                                     left: 8.0,
    //                                     right: 8.0,
    //                                     top: 8.0,
    //                                     bottom: 20,
    //                                   ),
    //                                   child: RichText(
    //                                       textAlign: TextAlign.center,
    //                                       text: TextSpan(children: [
    //                                         const TextSpan(
    //                                           text:
    //                                               'By continuing you agree to our \n',
    //                                           style: defaultStyle,
    //                                         ),
    //                                         TextSpan(
    //                                             text: 'Terms & Conditions',
    //                                             style: linkStyle,
    //                                             recognizer:
    //                                                 TapGestureRecognizer()
    //                                                   ..onTap = () {
    //                                                     //to do: navigate to terms and conditions
    //                                                   }),
    //                                         const TextSpan(
    //                                           text: ' and ',
    //                                           style: defaultStyle,
    //                                         ),
    //                                         TextSpan(
    //                                             text: 'Privacy Policy',
    //                                             style: linkStyle,
    //                                             recognizer:
    //                                                 TapGestureRecognizer()
    //                                                   ..onTap = () {
    //                                                     //
    //                                                   }),
    //                                       ])),
    //                                 )
    //                               ],
    //                             );
  }
}
