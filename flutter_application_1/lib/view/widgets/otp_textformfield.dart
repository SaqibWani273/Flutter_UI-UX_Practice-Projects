import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Repository/data_repo.dart';
import 'package:flutter_application_1/view_model/auth_bloc/auth_bloc_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/submit.dart';

class OtpTextFormField extends StatefulWidget {
  const OtpTextFormField({super.key});

  @override
  State<OtpTextFormField> createState() => _OtpTextFormFieldState();
}

class _OtpTextFormFieldState extends State<OtpTextFormField> {
  bool codeResend = false;
  late String number;

  final _otpControllers = List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  var otp = '';
  @override
  void initState() {
    super.initState();
    number = context.read<DataRepo>().mobileNumber!;
    //to automatically move focus to next editiing field
    for (var i = 0; i < _otpControllers.length; i++) {
      //for last digit
      _otpControllers[i].addListener(() {
        //move focus to next field except for  last field
        if (i < _otpControllers.length - 1) {
          if (_otpControllers[i].text.isNotEmpty) {
            otp += _otpControllers[i].text;
            _focusNodes[i + 1].requestFocus();
          }
        } else {
          if (_otpControllers[i].text.isNotEmpty) {
            _focusNodes[i].unfocus();
            otp += _otpControllers[i].text;
            context
                .read<AuthBlocBloc>()
                .add(SignInEvent(number: number, otp: otp));
            // submit(
            //   context: context,
            //   number: ref.read(authDataProvider).phoneNumber!,
            //   ref: ref,
            //   otp: otp,
            // );
          }
        }
      });
    }
  }

  @override
  void dispose() {
    for (var element in _focusNodes) {
      element.dispose();
    }

    for (var element in _otpControllers) {
      element.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
                6,
                (index) => Container(
                      padding: const EdgeInsets.all(8.0),
                      width: 50,
                      child: TextFormField(
                          controller: _otpControllers[index],
                          textInputAction: index < 5
                              ? TextInputAction.next
                              : TextInputAction.done,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          focusNode: _focusNodes[index],
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            counterText: '',
                          )),
                    )),
          ),
          const SizedBox(
            height: 10,
          ),
          codeResend
              ? TextButton(
                  onPressed: () {
                    context
                        .read<AuthBlocBloc>()
                        .add(SignInEvent(number: number));
                    // submit(
                    //   context: context,
                    //   number: ref.read(authDataProvider).phoneNumber!,
                    //   ref: ref,
                    // );
                  },
                  child: const Text("Resend code"))
              : SecondsBuilder(onEnd: () {
                  setState(() {
                    codeResend = true;
                  });
                }),
        ],
      ),
    );
  }
}

class SecondsBuilder extends StatelessWidget {
  final VoidCallback onEnd;
  const SecondsBuilder({super.key, required this.onEnd});
  final textStyle = const TextStyle(color: Colors.redAccent);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Resend code in ',
          style: textStyle,
        ),
        TweenAnimationBuilder(
            tween: Tween(
                begin: const Duration(seconds: 60),
                end: const Duration(seconds: 0)),
            duration: const Duration(seconds: 60),
            onEnd: onEnd,
            //  () {
            //   onEnd();
            // },
            builder: (context, value, child) {
              return Text(
                '${value.inSeconds} s ',
                style: textStyle,
              );
            })
      ],
    );
  }
}
