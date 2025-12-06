import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
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
        child: Column(
          children: [
            Center(
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://i.pinimg.com/736x/c9/47/a9/c947a977a9aa6a599ffe3f07bb0c9306.jpg",
                    ),
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
                  vertical: 5,
                  horizontal: 5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(20),
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

                trailing: Radio<String>(
                  activeColor: Colors.white,
                  value: "visa",
                  groupValue: "visa",
                  onChanged: (value) {}),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
