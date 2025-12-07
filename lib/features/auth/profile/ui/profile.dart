import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:sonic_app/core/routing/Routes.dart';
import 'package:sonic_app/core/theming/colorsapp.dart';
import 'package:sonic_app/core/widgets/custom_text.dart';
import 'package:sonic_app/features/auth/profile/ui/widgets/profile_text_filed.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _address = TextEditingController();

  @override
  void initState() {
    _name.text = "Amany";
    _email.text = "Amany@gmail.com";
    _address.text = "Mansoura";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.mainColor,
      appBar: AppBar(
        backgroundColor: ColorsApp.mainColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            child: SvgPicture.asset("assets/images/settings.svg", width: 20),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://i.pinimg.com/736x/ba/17/79/ba177909e597e913b6b41bb12102a2e9.jpg",
                      ),
                      onError: (_, __) =>
                          AssetImage("assets/images/error_image.png"),
                      fit: BoxFit.cover,
                    ),

                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 5, color: Colors.white),
                  ),
                ),
              ),
              Gap(30),
              ProfileTextFiled(controller: _name, label: "Name"),
              Gap(20),
              ProfileTextFiled(controller: _email, label: "Email"),
              Gap(20),
              ProfileTextFiled(controller: _address, label: "Address"),
              Gap(20),
              Divider(),
              Gap(10),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                tileColor: ColorsApp.componentColor,
                leading: Image.asset("assets/images/visa.png"),
                subtitle: CustomText(
                  text: "3566 **** **** 0505",
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                title: CustomText(
                  text: "Debit card",
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),

                trailing: CustomText(
                  text: "Default",
                  color: ColorsApp.mainColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),

      bottomSheet: SafeArea(
        child: Container(
          height: 100,
          decoration: BoxDecoration(color: ColorsApp.mainColor),

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      CustomText(
                        text: "Edit Profile",
                        color: ColorsApp.mainColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      Gap(5),
                      Icon(CupertinoIcons.pen, color: ColorsApp.mainColor),
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.login);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: ColorsApp.mainColor,
                      border: Border.all(width: 5, color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        CustomText(
                          text: "Logout",
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        Gap(5),
                        Icon(Icons.logout, color: Colors.white),
                      ],
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
