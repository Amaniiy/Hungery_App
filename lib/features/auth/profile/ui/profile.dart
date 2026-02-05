import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sonic_app/core/networking/api_error_model.dart';
import 'package:sonic_app/core/theming/colorsapp.dart';
import 'package:sonic_app/core/widgets/custom_text.dart';
import 'package:sonic_app/core/widgets/snack_bar_auth.dart';
import 'package:sonic_app/features/auth/data/auth_repo.dart';
import 'package:sonic_app/features/auth/data/user_model.dart';
import 'package:sonic_app/features/auth/login/ui/login_ui.dart';
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
  final TextEditingController _visa = TextEditingController();
  bool isLoading = false; // حالة Logout

  UserModel? userModel;
  AuthRepo authRepo = AuthRepo();

  //get profile data Api
  Future<void> _getProfileData() async {
    try {
      final user = await authRepo.getProfileData();

      setState(() {
        userModel = user;
      });
    } catch (e) {
      String errorMessage = "An error in profile ";
      if (e is ApiError) {
        errorMessage = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(authSnackBar(errorMessage));
    }
  }

  // Logout API
  Future<void> _logout() async {
    setState(() => isLoading = true);
    try {
      await authRepo.logout();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Logout failed. Try again.")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    //هنا بنجيب بيانات اليوزر
    _getProfileData().then((v) {
      _name.text = userModel?.name ?? '';
      _email.text = userModel?.email ?? '';
      _address.text = userModel?.address ?? '';
    });

    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.mainColor,
      appBar: AppBar(
        backgroundColor: ColorsApp.mainColor,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SvgPicture.asset("assets/images/settings.svg", width: 20),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: Colors.white,
        backgroundColor: ColorsApp.mainColor,
        onRefresh: () async {
          await _getProfileData();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Skeletonizer(
              enabled: userModel == null,
              child: Column(
                children: [
                  Center(
                    //profile image Api
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        image:
                            //image Api
                            userModel?.image != null &&
                                userModel!.image!.isNotEmpty
                            ? DecorationImage(
                                image: NetworkImage(userModel!.image!),
                                onError: (_, __) => const AssetImage(
                                  "assets/images/error_image.png",
                                ),
                                fit: BoxFit.cover,
                              )
                            : null,
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(width: 5, color: Colors.white),
                      ),
                    ),
                  ),
                  const Gap(30),
                  ProfileTextFiled(controller: _name, label: "Name"),
                  const Gap(20),
                  ProfileTextFiled(controller: _email, label: "Email"),
                  const Gap(20),
                  ProfileTextFiled(controller: _address, label: "Address"),
                  const Gap(20),
                  const Divider(),
                  const Gap(10),
                  userModel?.visa == null
                      ?
                        //لو اليوزر مدخلش فيزا قبل كدا هيظهرلوا المكان دا عشان يدخله لاول مره وبعدي كدا يظهرله جزء الفيزا العادي
                        ProfileTextFiled(
                          controller: _visa,
                          label: "ADD VISA CARD",
                          textInputType: TextInputType.number,
                        )
                      : ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          tileColor: ColorsApp.componentColor,
                          leading: Image.asset("assets/images/visa.png"),
                          subtitle: CustomText(
                            text: userModel?.visa ?? "3566 **** **** 0505",
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          title: const CustomText(
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
                // Edit Profile Button
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const CustomText(
                        text: "Edit Profile",
                        color: ColorsApp.mainColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      const Gap(5),
                      Icon(CupertinoIcons.pen, color: ColorsApp.mainColor),
                    ],
                  ),
                ),

                // Logout Button
                GestureDetector(
                  onTap: isLoading ? null : _logout,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: ColorsApp.mainColor,
                      border: Border.all(width: 5, color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        isLoading
                            ? const CupertinoActivityIndicator(
                                color: Colors.white,
                              )
                            : const CustomText(
                                text: "Logout",
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                        const Gap(6),
                        const Icon(Icons.logout, color: Colors.white),
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
//مهم نستخدم Skeletonizer عشان يبان ان الصفحه كلها بتحمل