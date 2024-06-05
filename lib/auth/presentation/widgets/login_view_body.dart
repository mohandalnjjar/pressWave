import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pressWave/auth/presentation/managers/login_cubit/login_cubit.dart';
import 'package:pressWave/core/functions/showed_scaffold_message.dart';
import 'package:pressWave/core/functions/validators.dart';
import 'package:pressWave/core/widgets/second_custom_text_form_filed.dart';
import 'package:pressWave/core/utilities/constance/app_router_constance.dart';
import 'package:pressWave/core/utilities/styles.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({
    super.key,
  });

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  late TextEditingController _emialControler;
  late final TextEditingController _passwordControler;

  late final FocusNode _emailFoucsNode;
  late final FocusNode _passwordFoucsNode;
  @override
  void initState() {
    _emialControler = TextEditingController();
    _passwordControler = TextEditingController();

    //focusNodes

    _emailFoucsNode = FocusNode();
    _passwordFoucsNode = FocusNode();

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

    super.dispose();
  }

  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool obscureText = true;
  String? email, pasword;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoadding) {
          showDialog(
            context: context,
            builder: (context) => const AbsorbPointer(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        if (state is LoginSuccess) {
          showedScaffoldMessage(
              context: context, message: 'Successfully Login');

          GoRouter.of(context).pushReplacement(RouterConstance.kRootViewRouter);
        }

        if (state is LoginFailure) {
          showedScaffoldMessage(context: context, message: state.errorMessage);
          context.pop();
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(13),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                autovalidateMode: autovalidateMode,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Login',
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
                      controller: _emialControler,
                      focusNode: _emailFoucsNode,
                      hint: 'Email',
                      validator: (value) {
                        return Validators.emailValidator(value);
                      },
                      onFieldSubmitted: (value) => FocusScope.of(context)
                          .requestFocus(_passwordFoucsNode),
                      obscureText: false,
                      onSaved: (value) {
                        email = value;
                      },
                    ),
                    const SizedBox(
                      height: 23,
                    ),
                    SecondCustomTextFromField(
                      obscureText: obscureText,
                      controller: _passwordControler,
                      hint: 'Password',
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
                      focusNode: _passwordFoucsNode,
                      onSaved: (value) {
                        pasword = value;
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Forgot password?',
                      style:
                          AppStyles.styleRegular15(context).copyWith(color: Colors.grey),
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
                          FocusScope.of(context).unfocus();

                          await BlocProvider.of<LoginCubit>(context)
                              .loginMethod(
                            email: _emialControler.value.text,
                            password: _passwordControler.text,
                          );
                        } else {
                          setState(() {
                            autovalidateMode = AutovalidateMode.always;
                          });
                        }
                      },
                      child: Text(
                        'Login',
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
                          'Don\'t have account ?!',
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
                            await GoRouter.of(context)
                                .push(RouterConstance.kSingUpViewRouter);
                          },
                          child: Text(
                            'Sign up',
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
}
