import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sonic_app/core/networking/api_error_model.dart';
import 'package:sonic_app/core/theming/colorsapp.dart';
import 'package:sonic_app/core/widgets/custom_text.dart';
import 'package:sonic_app/core/widgets/snack_bar_auth.dart';
import 'package:sonic_app/core/widgets/text_form_field.dart';
import 'package:sonic_app/features/auth/data/auth_repo.dart';
import 'package:sonic_app/features/auth/login/ui/login_ui.dart';
import 'package:sonic_app/root.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  //Api
  AuthRepo authRepo = AuthRepo();
  Future<void> _signup() async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() => isLoading = true);
        final user = await authRepo.signup(
          _nameController.text.trim(),
          _emailController.text.trim(),
          _passwordController.text.trim(),
          _confirmPasswordController.text.trim(),
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
        String errorMessage = 'An error in signup. Please try again.';
        if (e is ApiError) {
          errorMessage = e.message;
        }
        ScaffoldMessenger.of(context).showSnackBar(authSnackBar(errorMessage));
      }
    }
  }

  /////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.mainColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Gap(100),
                  SvgPicture.asset('assets/images/logo.svg'),
                  Gap(70),

                  CustomTextFormField(
                    isPassword: false,
                    controller: _nameController,
                    hintText: "Name",
                  ),
                  Gap(15),

                  CustomTextFormField(
                    isPassword: false,
                    controller: _emailController,
                    hintText: "Email",
                  ),
                  Gap(15),
                  CustomTextFormField(
                    isPassword: true,
                    controller: _passwordController,
                    hintText: "Password",
                  ),
                  Gap(15),
                  CustomTextFormField(
                    isPassword: true,
                    controller: _confirmPasswordController,
                    hintText: "Confirm Password",
                  ),
                  Gap(15),

                  isLoading
                      ? CupertinoActivityIndicator()
                      : GestureDetector(
                          onTap: () {
                            _signup();
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
                              child: CustomText(
                                text: "Signup",
                                color: ColorsApp.mainColor,
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),

                  CustomText(
                    text: "login",
                    onpressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginScreen();
                          },
                        ),
                      );
                    },
                    color: ColorsApp.mainColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
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
