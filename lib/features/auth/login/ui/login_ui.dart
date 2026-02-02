import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sonic_app/core/networking/api_error_model.dart';
import 'package:sonic_app/core/routing/Routes.dart';
import 'package:sonic_app/core/theming/colorsapp.dart';
import 'package:sonic_app/core/widgets/custom_text.dart';
import 'package:sonic_app/core/widgets/text_form_field.dart';
import 'package:sonic_app/features/auth/data/auth_repo.dart';
import 'package:sonic_app/root.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  //Api///////////////////////////////////////////////////////////
  AuthRepo authRepo = AuthRepo();
  Future<void> login() async {
    if (!_formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      try {
        final user = await authRepo.login(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
        if (user != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Root()),
          );
        }
        setState(() => isLoading = false);
      } catch (e) {
        setState(() => isLoading = false);
        String errorMessage = "unhandled error";

        if (e is ApiError) {
          errorMessage = e.message;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            elevation: 10,
            margin: EdgeInsets.only(bottom: 35, left: 20, right: 20),
            clipBehavior: Clip.none,
            backgroundColor: Colors.red[900],
            content: Row(
              children: [
                Icon(Icons.error_outline, color: Colors.white),
                Gap(10),
                CustomText(
                  text: 'An error occurred: $errorMessage',
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
        );
      }
    }
  }

  ///////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: ColorsApp.mainColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Gap(100),
                  SvgPicture.asset('assets/images/logo.svg'),
                  Gap(10),

                  CustomText(
                    text: "welcome back,discover the fast food",
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  Gap(70),
                  CustomTextFormField(
                    isPassword: false,
                    controller: _emailController,
                    hintText: "Email",
                  ),
                  Gap(20),
                  CustomTextFormField(
                    isPassword: true,
                    controller: _passwordController,
                    hintText: "Password",
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {}
                      Navigator.pushNamed(context, Routes.roots);
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : CustomText(
                                //api
                                onPressed: login,
                                //
                                text: "Login",
                                color: ColorsApp.mainColor,
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
