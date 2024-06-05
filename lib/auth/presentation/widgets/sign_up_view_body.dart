import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pressWave/auth/presentation/managers/signup/sign_up_cubit.dart';
import 'package:pressWave/core/functions/showed_scaffold_message.dart';
import 'package:pressWave/core/functions/validators.dart';
import 'package:pressWave/core/widgets/second_custom_text_form_filed.dart';
import 'package:pressWave/core/utilities/constance/app_router_constance.dart';
import 'package:pressWave/core/utilities/styles.dart';

class SingUpViewBody extends StatefulWidget {
  const SingUpViewBody({
    super.key,
  });

  @override
  State<SingUpViewBody> createState() => _SingUpViewBodyState();
}

class _SingUpViewBodyState extends State<SingUpViewBody> {
  late TextEditingController _userNameControler;

  late TextEditingController _emialControler;
  late final TextEditingController _passwordControler;
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  late final FocusNode _emailFoucsNode;
  late final FocusNode _passwordFoucsNode;
  late final FocusNode _repeatpasswordFoucsNode;
  @override
  void initState() {
    _userNameControler = TextEditingController();
    _emialControler = TextEditingController();
    _passwordControler = TextEditingController();

    //focusNodes

    _emailFoucsNode = FocusNode();
    _passwordFoucsNode = FocusNode();
    _repeatpasswordFoucsNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    //contollers
    _emialControler.dispose();
    _passwordControler.dispose();
    _userNameControler.dispose();

    //focus nodes
    _emailFoucsNode.dispose();
    _passwordFoucsNode.dispose();
    _repeatpasswordFoucsNode.dispose();

    super.dispose();
  }

  bool obscureText = true;
  String? email, pasword;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpLoadding) {
          showDialog(
            context: context,
            builder: (context) => const AbsorbPointer(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        if (state is SignUpSuccess) {
          showedScaffoldMessage(
              context: context, message: 'Successfully Login');
          GoRouter.of(context).pushReplacement(RouterConstance.kRootViewRouter);
        }
        if (state is SignUpFailure) {
          showedScaffoldMessage(context: context, message: state.errorMessage);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(13),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                autovalidateMode: autovalidateMode,
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text(
                      'Sing Up',
                      style: AppStyles.styleSemiBold41(context),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                     Text(
                      'Enter your account details',
                      style: AppStyles.styleRegular16(context),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SecondCustomTextFromField(
                      controller: _userNameControler,
                      hint: 'User name',
                      validator: (value) {
                        return Validators.nameValidator(value);
                      },
                      onFieldSubmitted: (value) =>
                          FocusScope.of(context).requestFocus(_emailFoucsNode),
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 23,
                    ),
                    SecondCustomTextFromField(
                      focusNode: _emailFoucsNode,
                      controller: _emialControler,
                      hint: 'Email',
                      onSaved: (value) {
                        email = value;
                      },
                      validator: (value) {
                        return Validators.emailValidator(value);
                      },
                      onFieldSubmitted: (value) => FocusScope.of(context)
                          .requestFocus(_passwordFoucsNode),
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 23,
                    ),
                    SecondCustomTextFromField(
                      controller: _passwordControler,
                      focusNode: _passwordFoucsNode,
                      hint: 'Password',
                      onSaved: (value) {
                        pasword = value;
                      },
                      validator: (value) {
                        return Validators.passwordValidator(value);
                      },
                      suffixIcon: IconButton(
                        icon: Icon(obscureText
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                      ),
                      onFieldSubmitted: (value) => FocusScope.of(context)
                          .requestFocus(_repeatpasswordFoucsNode),
                      obscureText: obscureText,
                    ),
                    const SizedBox(
                      height: 23,
                    ),
                    SecondCustomTextFromField(
                      focusNode: _repeatpasswordFoucsNode,
                      hint: 'Repeat password',
                      suffixIcon: IconButton(
                        icon: Icon(obscureText
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                      ),
                      validator: (value) {
                        return Validators.repeatPasswordValidaotr(
                            value: value, password: _passwordControler.text);
                      },
                      obscureText: obscureText,
                    ),
                    const SizedBox(
                      height: 37,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(13),
                      ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();

                          await BlocProvider.of<SignUpCubit>(context)
                              .signUpMethod(email: email!, password: pasword!);
                          await addUsersData(
                            userName: _userNameControler.text.trim(),
                            email: _emialControler.text.trim(),
                          );
                        } else {
                          setState(() {
                            autovalidateMode = AutovalidateMode.always;
                          });
                        }
                      },
                      child: Text(
                        'Sign up',
                        style: AppStyles.styleSemiBold18(context).copyWith(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 42,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Do you have account ?!',
                          style: AppStyles.styleRegular15(context)
                              .copyWith(color: Colors.grey),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.withOpacity(0.1),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                          ),
                          onPressed: () async {
                            await GoRouter.of(context).pushReplacement(
                                RouterConstance.kLoginViewRouter);
                          },
                          child: Text(
                            'Login',
                            style: AppStyles.styleSemiBold18(context).copyWith(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> addUsersData({
    required String userName,
    required String email,
  }) async {
    User? user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
      'userImage': '',
      'UserName': userName,
      'Email': email,
      'CreatedAt': Timestamp.now(),
      'UserSavedNews': [],
      'UserRecentlyReadNews': []
    });
  }
}
