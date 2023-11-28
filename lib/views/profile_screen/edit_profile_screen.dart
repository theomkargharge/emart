// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:emart/common_widget/bg_widgets.dart';
import 'package:emart/common_widget/common_button.dart';
import 'package:emart/common_widget/common_toast.dart';
import 'package:emart/common_widget/custtom.textfield.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/controller/profile_controller/profile_controller.dart';
import 'package:emart/views/custtom_navbar/custtom_navbar.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var profileController = Get.find<ProfileController>();

    return bgWidget(
        child: GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(),
          body: Obx(
            () => Column(
              children: [
                data['imageUrl'] == '' &&
                        profileController.profileImagePath.value.isEmpty
                    ? Image.asset(
                        imgProfile2,
                        width: 80,
                      ).box.roundedFull.clip(Clip.antiAlias).make()
                    : data['imageUrl'] != '' &&
                            profileController.profileImagePath.value.isEmpty
                        ? Image.network(
                            data['imageUrl'],
                            width: 80,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make()
                        : Image.file(
                            File(Get.find<ProfileController>()
                                .profileImagePath
                                .value),
                            width: 80,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make(),
                10.heightBox,
                commonButton(
                    bgcolor: redColor,
                    onPressed: () {
                      profileController.changeImage(context: context);
                    },
                    textColor: whiteColor,
                    title: 'Changes'),
                const Divider(),
                20.heightBox,
                customTextField(
                    controller: profileController.nameController,
                    hintText: hintNametext,
                    textMessage: textName,
                    obSecureText: false),
                customTextField(
                    validator: (value) {
                      if (value == null) {
                        return "Password can't be empty";
                      } else if (value.length < 6 || value.length > 10) {
                        return "password must have at least 6 characters and maximum of 10 characters";
                      } else if (!RegExp(
                              r'^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[!@#$%^&*()_+])[a-zA-Z0-9!@#$%^&*()_+]+$')
                          .hasMatch(value)) {
                        return 'password must contain at least one digit, one special character, and Letters';
                      }
                      return null;
                    },
                    suffixIcon: GestureDetector(
                      onTap: () {
                        profileController.isShowPassword.value =
                            !profileController.isShowPassword.value;
                      },
                      child: Icon(profileController.isShowPassword.value
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                    hintText: hintPassword,
                    textMessage: oldPassword,
                    controller: profileController.oldController,
                    obSecureText: !profileController.isShowPassword.value),
                10.heightBox,
                customTextField(
                    validator: (value) {
                      if (value == null) {
                        return "Password can't be empty";
                      } else if (value.length < 6 || value.length > 10) {
                        return "password must have at least 6 characters and maximum of 10 characters";
                      } else if (!RegExp(
                              r'^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[!@#$%^&*()_+])[a-zA-Z0-9!@#$%^&*()_+]+$')
                          .hasMatch(value)) {
                        return 'password must contain at least one digit, one special character, and Letters';
                      }
                      return null;
                    },
                    suffixIcon: GestureDetector(
                      onTap: () {
                        profileController.isShowPassword.value =
                            !profileController.isShowPassword.value;
                      },
                      child: Icon(profileController.isShowPassword.value
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                    hintText: hintPassword,
                    textMessage: newPassword,
                    controller: profileController.newpasswordController,
                    obSecureText: !profileController.isShowPassword.value),
                profileController.isloading.value
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      )
                    : SizedBox(
                        width: context.screenWidth - 60,
                        child: commonButton(
                            bgcolor: redColor,
                            onPressed: () async {
                              try {
                                profileController.isloading(true);
                                if (profileController
                                    .profileImagePath.value.isNotEmpty) {
                                  await profileController.uploadProfileImage();
                                } else {
                                  profileController.profileImageLink =
                                      data['imageUrl'];
                                }

                                if (data['password'] ==
                                    profileController.oldController.text) {
                                  await profileController.changeAuthPassword(
                                      email: data['email'],
                                      password:
                                          profileController.oldController.text,
                                      newpassword: profileController
                                          .newpasswordController.text);
                                  await profileController.updateProfile(
                                      imgUrl:
                                          profileController.profileImageLink,
                                      name:
                                          profileController.nameController.text,
                                      password: profileController
                                          .newpasswordController.text);
                                  showMessage(
                                      context: context,
                                      msg: 'Profile Updated ');
                                  Get.to(() => const CusttomNavBar());
                                  profileController.isloading(false);
                                } else {
                                  showMessage(
                                      context: context,
                                      msg: 'You Enter Wrong Old Password');
                                  profileController.isloading(false);
                                }
                              } catch (e) {
                                showMessage(
                                    context: context, msg: e.toString());
                              }
                            },
                            textColor: whiteColor,
                            title: 'Save'),
                      )
              ],
            )
                .box
                .white
                .shadowSm
                .padding(const EdgeInsets.all(16))
                .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
                .rounded
                .make(),
          )),
    ));
  }
}
