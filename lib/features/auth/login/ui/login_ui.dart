import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sonic_app/core/networking/api_error_model.dart';
import 'package:sonic_app/core/theming/colorsapp.dart';
import 'package:sonic_app/core/widgets/custom_text.dart';
import 'package:sonic_app/core/widgets/snack_bar_auth.dart';
import 'package:sonic_app/core/widgets/text_form_field.dart';
import 'package:sonic_app/features/auth/data/auth_repo.dart';
import 'package:sonic_app/features/auth/signup/ui/signup.dart';
import 'package:sonic_app/root.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  // Api
  final AuthRepo authRepo = AuthRepo();

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      try {
        final user = await authRepo.login(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );

        if (user != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => Root()),
          );
        }
      } catch (e) {
        String errorMessage = "Unhandled error";
        if (e is ApiError) errorMessage = e.message;
        ScaffoldMessenger.of(context).showSnackBar(authSnackBar(errorMessage));
      } finally {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                  const Gap(100),
                  SvgPicture.asset('assets/images/logo.svg'),
                  const Gap(10),
                  const CustomText(
                    text: "Welcome back, discover the fast food",
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  const Gap(70),
                  CustomTextFormField(
                    isPassword: false,
                    controller: _emailController,
                    hintText: "Email",
                  ),
                  const Gap(20),
                  CustomTextFormField(
                    isPassword: true,
                    controller: _passwordController,
                    hintText: "Password",
                  ),
                  GestureDetector(
                    onTap: isLoading ? null : login,
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: isLoading
                            ? const CircularProgressIndicator()
                            : const CustomText(
                                text: "Login",
                                color: ColorsApp.mainColor,
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                              ),
                      ),
                    ),
                  ),
                  const Gap(20),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const Signup()),
                      );
                    },
                    child: const CustomText(
                      text: "Signup",
                      color: ColorsApp.mainColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
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
