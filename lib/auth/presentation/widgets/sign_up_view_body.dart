import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pressWave/auth/presentation/managers/signup/sign_up_cubit.dart';
import 'package:pressWave/core/functions/showed_scaffold_message.dart';
import 'package:pressWave/core/functions/validators.dart';
import 'package:pressWave/core/second_custom_text_form_filed.dart';
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
  late TextEditingController _emialControler;
  late final TextEditingController _passwordControler;
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  late final FocusNode _emailFoucsNode;
  late final FocusNode _passwordFoucsNode;
  late final FocusNode _repeatpasswordFoucsNode;
  @override
  void initState() {
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
                const Text(
                  'Sing Up',
                  style: AppStyles.styleSemiBold41,
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  'Enter your account details',
                  style: AppStyles.styleRegular16
                      .copyWith(color: Colors.white.withOpacity(0.8)),
                ),
                const SizedBox(
                  height: 16,
                ),
                SecondCustomTextFromField(
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
                  onFieldSubmitted: (value) =>
                      FocusScope.of(context).requestFocus(_passwordFoucsNode),
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
                    icon: Icon(
                        obscureText ? Icons.visibility : Icons.visibility_off),
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
                    icon: Icon(
                        obscureText ? Icons.visibility : Icons.visibility_off),
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
                BlocBuilder<SignUpCubit, SignUpState>(
                  builder: (context, state) {
                    return ElevatedButton(
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
                          if (state is SignUpLoadding) {
                            showDialog(
                              context: context,
                              builder: (context) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else if (state is SignUpSuccess) {
                            context.pop;

                            showedScaffoldMessage(
                                context: context,
                                message: 'Successfully Login');
                            await GoRouter.of(context).pushReplacement(
                                RouterConstance.kRootViewRouter);
                          } else if (state is SignUpFailure) {
                            showedScaffoldMessage(
                                context: context, message: state.errorMessage);
                          }
                        } else {
                          setState(() {
                            autovalidateMode = AutovalidateMode.always;
                          });
                        }
                      },
                      child: Text(
                        'Sign up',
                        style: AppStyles.styleSemiBold18.copyWith(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 42,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Do you have account ?!',
                      style:
                          AppStyles.styleRegular15.copyWith(color: Colors.grey),
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
                        await GoRouter.of(context)
                            .pushReplacement(RouterConstance.kLoginViewRouter);
                      },
                      child: Text(
                        'Login',
                        style: AppStyles.styleSemiBold18.copyWith(
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
  }
}
