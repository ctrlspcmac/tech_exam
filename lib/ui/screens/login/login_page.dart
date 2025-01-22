import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maya_tech_exam/configs/colors.dart';
import 'package:maya_tech_exam/configs/constants.dart';
import 'package:maya_tech_exam/configs/images.dart';
import 'package:maya_tech_exam/domains/datasource/models/login/usercred_data.dart';
import 'package:maya_tech_exam/routes.dart';
import 'package:maya_tech_exam/states/sign_in_bloc/sign_in_bloc.dart';
import 'package:maya_tech_exam/utils/alert_dialog_utils.dart';
import 'package:maya_tech_exam/utils/extensions/string_regex_extensions.dart';
import 'package:maya_tech_exam/utils/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false; // To toggle the visibility of password
  String? _usernameErrorText;
  String? _passwordErrorText;

  void _login() {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.emptyCredentials)),
      );
    } else {
      LoggerUtil.info("Login Successful");
      //call api
      scheduleMicrotask(() {
        context.read<SignInBloc>().add(
            SignInRequired(body: UserCredentialsModel(username, password)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorPrimary,
      body: Padding(
        padding: const EdgeInsets.all(0).safePadding,
        child: BlocListener<SignInBloc, SignInState>(
          listener: (BuildContext context, SignInState state) {
            if (state.status == SignInStatus.loading) {
              //show loading
              AlertDialogUtils.showLoadingAlertDialog(context: context);
            } else if (state.status == SignInStatus.success) {
              //hide loading
              AlertDialogUtils.hideAlertDialog(context: context);
              AppNavigator.replaceWith(Routes.dashboard,
                  {'accountId': state.body?.accountId.toString()});
            } else if (state.status == SignInStatus.failure) {
              AlertDialogUtils.hideAlertDialog(context: context);
              //show error msg
              Utils.showSnackBar(context, state.error.toString());
            }
          },
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0).safePadding,
                    child: Text(AppStrings.appTitle,
                        style: const TextStyle(
                            fontSize: 32,
                            height: 1,
                            color: AppColors.colorSecondary)),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0).safePadding,
                    child: Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text: 'By signing in you are agreeing to our ',
                        // Normal text
                        style:
                            TextStyle(fontSize: 12, color: AppColors.subTitle),
                        // Default style
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Terms and Privacy Policy',
                              // Text to be styled
                              style: TextStyle(
                                  color: Colors.blue, fontSize: 12, height: 1),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  LoggerUtil.info("GOTO TERMS");
                                } // Blue color
                              ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(AppStrings.loginTitle,
                      style: const TextStyle(
                          fontSize: 20, height: 1, color: AppColors.black)),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                            left: 32.0, right: 32.0, top: 15, bottom: 0)
                        .safePadding,
                    child: TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: AppStrings.username,
                        hintText: AppStrings.username,
                        errorText: _usernameErrorText,
                        errorStyle: const TextStyle(color: Colors.red),
                        errorMaxLines: 2,
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Image(image: AppImages.usernameImg),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.lineColor,
                              width: 1), // Customize color and width
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.lineColor,
                              width: 1), // Default color and width
                        ),
                      ),
                      validator: (value) => _usernameErrorText,
                      onChanged: validateUsername,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                            left: 32.0, right: 32.0, top: 15, bottom: 0)
                        .safePadding,
                    //padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: AppStrings.password,
                        hintText: AppStrings.password,
                        errorText: _passwordErrorText,
                        errorStyle: const TextStyle(color: Colors.red),
                        errorMaxLines: 2,
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: const Icon(Icons.lock_outline,
                            color: AppColors.lineColor),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.lineColor,
                              width: 1), // Customize color and width
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.lineColor,
                              width: 1), // Default color and width
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible =
                                  !_isPasswordVisible; // Toggle password visibility
                            });
                          },
                        ),
                      ),
                      validator: (value) => _passwordErrorText,
                      onChanged: validatePassword,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 32).safePadding,
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.colorSecondary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        key: const Key('loginButton'),
                        onPressed: () {
                          _login();
                          //AppNavigator.replaceWith(Routes.dashboard);
                        },
                        child: const Text(
                          AppStrings.loginButton,
                          style:
                              TextStyle(color: AppColors.black, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Stack(
                          fit: StackFit.loose,
                          alignment: Alignment.center,
                          children: [
                            Image(
                              image: AppImages.loginBottomImage,
                              fit: BoxFit.fitWidth,
                              alignment: Alignment.bottomCenter,
                            ),
                            // Image(
                            //   image: AppImages.bottomImage,
                            //   fit: BoxFit.fill,
                            //   alignment: Alignment.bottomCenter,
                            // ),
                            Image(
                              image: AppImages.bottomImage,
                              fit: BoxFit.fitWidth,
                              alignment: Alignment.bottomCenter,
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void validateUsername(String value) {
    if (value.isEmpty) {
      setState(() {
        _usernameErrorText = 'Username is required';
      });
    } else if (!(value.length > 5)) {
      setState(() {
        _usernameErrorText = 'Username must be at least 6 characters';
      });
    } else if (!value.isValidUserName) {
      setState(() {
        _usernameErrorText = 'Username must start at a letter and no special '
            'characters';
      });
    } else {
      setState(() {
        _usernameErrorText = null;
      });
    }
  }

  void validatePassword(String value) {
    if (value.isEmpty) {
      setState(() {
        _passwordErrorText = 'Password is required';
      });
    } else if (!(value.length > 7)) {
      setState(() {
        _passwordErrorText = 'Password must be at least 8 characters';
      });
    } else if (!value.isValidPassword) {
      setState(() {
        _passwordErrorText = 'Password must contain upper, lower, digit and'
            ' special character (!@#\$%^&*)';
      });
    } else {
      setState(() {
        _passwordErrorText = null;
      });
    }
  }
}
