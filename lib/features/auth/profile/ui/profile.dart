import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
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
  bool isLoadingUpdating = false; // حالة update profile
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

  //update profile Api
  Future<void> _updateProfile() async {
    try {
      setState(() => isLoadingUpdating = true);
      final user = await authRepo.updateProfileData(
        name: _name.text.trim(),
        email: _email.text.trim(),
        address: _address.text.trim(),
        visa: _visa.text.trim(),
        imagepath: selectedImage,
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(authSnackBar("Profile updated successfully!"));
      setState(() => isLoadingUpdating = false);
      //بعد ما بنعمل تحديث للبيانات بنحدث اليوزر موديل عشان يبان في الصفحه
      setState(() => userModel = user);
      await _getProfileData();
    } catch (e) {
      setState(() => isLoadingUpdating = false);

      String errorMessage = "Failed to update profile.";
      if (e is ApiError) {
        errorMessage = e.message;
        print(errorMessage);
      }
    }
  }

  //image picker
  String? selectedImage;
  Future<void> _pickImage() async {
    final pickerImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickerImage != null) {
      setState(() {
        selectedImage = pickerImage.path;
      });
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
    _visa.dispose();
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
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 1, color: Colors.black),
                        color: Colors.grey.shade300,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(1),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.all(3),
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 1,
                                color: ColorsApp.mainColor,
                              ),
                              color: Colors.grey.shade100,
                            ),
                            clipBehavior: Clip.antiAlias,
                            //لو اليوزر اختار صورة جديدة من الجاليري بنعرضها لو مش اختار بنعرض الصورة القديمة لو موجودة ولو مفيش صورة خالص بنعرض ايقونة الشخص الافتراضية
                            //Api!!!!!!!!!!
                            child: selectedImage != null
                                ? Image.file(
                                    File(selectedImage!),
                                    fit: BoxFit.cover,
                                  )
                                : (userModel?.image != null &&
                                      userModel!.image!.isNotEmpty)
                                ? Image.network(
                                    userModel!.image!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, err, builder) =>
                                        Icon(Icons.person),
                                  )
                                : Icon(Icons.person),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Gap(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: _pickImage,
                        child: Card(
                          elevation: 0.0,
                          color: const Color.fromARGB(255, 6, 78, 13),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 8,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomText(
                                  text: 'Upload',
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                                Gap(10),
                                Icon(
                                  CupertinoIcons.camera,
                                  size: 17,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      //مفيش Api
                      GestureDetector(
                        onTap: _pickImage,
                        child: Card(
                          elevation: 0.0,
                          color: const Color.fromARGB(255, 111, 2, 40),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 8,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomText(
                                  text: 'Remove',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                                Gap(10),
                                Icon(
                                  CupertinoIcons.trash,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ), //Form
                  ProfileTextFiled(controller: _name, label: "Name"),
                  const Gap(20),
                  ProfileTextFiled(controller: _email, label: "Email"),
                  const Gap(20),
                  ProfileTextFiled(controller: _address, label: "Address"),
                  const Gap(20),
                  const Divider(),
                  const Gap(10),

                  //Visa Card
                  //هنا بنشوف اذا اليوزر مدخلش فيزا قبل كدا هيظهر له المكان دا عشان يدخله لاول مره وبعدي كدا يظهرله جزء الفيزا العادي
                  userModel?.visa == null
                      ? ProfileTextFiled(
                          controller: _visa,
                          label: "ADD VISA CARD",
                          //الكيبورد تبقي ارقام بس
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
                            //هنا بنعرض اخر 4 ارقام من الفيزا لو موجودة في اليوزر موديل لو مش موجودة بنعرض رقم افتراضي
                            //Api!!!!!!!!!!
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
                  //دا الزرار بتاع تحديث بيانات البروفايل لو اليوزر بيعمل تحديث هيظهر له مؤشر تحميل لو مش بيعمل تحديث هيظهر له ايقونة القلم وكلمة Edit Profile
                  child: isLoadingUpdating
                      ? CupertinoActivityIndicator(color: ColorsApp.mainColor)
                      : GestureDetector(
                          //Api to update all profile data
                          onTap: _updateProfile,
                          child: Row(
                            children: [
                              CustomText(
                                text: "Edit Profile",
                                color: ColorsApp.mainColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                              const Gap(5),
                              Icon(
                                CupertinoIcons.pen,
                                color: ColorsApp.mainColor,
                              ),
                            ],
                          ),
                        ),
                ),

                // Logout Button
                GestureDetector(
                  //Api to logout
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