import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sonic_app/core/routing/Routes.dart';
import 'package:sonic_app/core/theming/colorsapp.dart';
import 'package:sonic_app/core/widgets/custom_text.dart';
import 'package:sonic_app/core/widgets/text_form_field.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _nameController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _confirmPasswordController = TextEditingController();

    final _formKey = GlobalKey<FormState>();

    return Scaffold(
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
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {}
                    Navigator.pushNamed(context, Routes.login);
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
