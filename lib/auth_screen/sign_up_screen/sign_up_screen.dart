import 'package:emart/common_widget/applogo_widget.dart';
import 'package:emart/common_widget/bg_widgets.dart';
import 'package:emart/common_widget/common_button.dart';
import 'package:emart/common_widget/common_toast.dart';
import 'package:emart/common_widget/custtom.textfield.dart';
import 'package:emart/controller/firebase_controller/auth_controller.dart';
import 'package:emart/controller/sign_up_controller/sign_up_controller.dart';
import 'package:emart/views/custtom_navbar/custtom_navbar.dart';

import 'package:get/get.dart';

import '../../consts/consts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var controllar = Get.put(AuthController());
  var signUpcontrollar = Get.put(SignUpController());

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isChecked = false;

  bool signupValidation(
    String email,
    String password,
    String name,
    String phone,
  ) {
    if (email.isEmpty && password.isEmpty && name.isEmpty && phone.isEmpty) {
      showMessage(context: context, msg: 'All fields are empty');
      return false;
    } else if (email.isEmpty) {
      showMessage(context: context, msg: 'Email is Empty');
      return false;
    } else if (name.isEmpty) {
      showMessage(context: context, msg: 'Name is Empty');
      return false;
    } else if (phone.isEmpty) {
      showMessage(context: context, msg: 'Phone is Empty');
      return false;
    } else if (password.isEmpty) {
      showMessage(context: context, msg: 'Password is Empty');
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Column(
              children: [
                (context.screenHeight * 0.1).heightBox,
                applogoWidget(),
                10.heightBox,
                'Join to $appname'.text.fontFamily(bold).white.size(22).make(),
                15.heightBox,
                Obx(
                  () => SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        customTextField(
                            hintText: hintNametext,
                            textMessage: textName,
                            controller: nameController),
                        customTextField(
                            hintText: hintEmail,
                            textMessage: email,
                            controller: emailController),
                        customTextField(
                            validator: (value) {
                              if (value == null) {
                                return "Password can't be empty";
                              } else if (value.length < 6 ||
                                  value.length > 10) {
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
                                signUpcontrollar.isShowPassword.value =
                                    !signUpcontrollar.isShowPassword.value;
                              },
                              child: Icon(signUpcontrollar.isShowPassword.value
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                            hintText: hintPassword,
                            textMessage: password,
                            controller: passwordController,
                            obSecureText:
                                !signUpcontrollar.isShowPassword.value),
                        customTextField(
                            validator: (value) {
                              if (value == null) {
                                return "Password can't be empty";
                              } else if (value.length < 6 ||
                                  value.length > 10) {
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
                                signUpcontrollar.isShowPassword.value =
                                    !signUpcontrollar.isShowPassword.value;
                              },
                              child: Icon(signUpcontrollar.isShowPassword.value
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                            hintText: hintPassword,
                            textMessage: textConfirmPassword,
                            controller: confirmPasswordController,
                            obSecureText:
                                !signUpcontrollar.isShowPassword.value),
                        10.heightBox,
                        Row(
                          children: [
                            Checkbox(
                              value: isChecked,
                              onChanged: (newVaalue) {
                                setState(() {
                                  isChecked = newVaalue!;
                                });
                              },
                              activeColor: redColor,
                              checkColor: whiteColor,
                            ),
                            Flexible(
                              child: RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'I agree to the ',
                                      style: TextStyle(
                                          fontFamily: bold, color: fontGrey),
                                    ),
                                    TextSpan(
                                      text: 'Terms and Conditions ',
                                      style: TextStyle(
                                          fontFamily: bold, color: redColor),
                                    ),
                                    TextSpan(
                                      text: '& ',
                                      style: TextStyle(
                                          fontFamily: bold, color: fontGrey),
                                    ),
                                    TextSpan(
                                      text: 'Privacy Policy ',
                                      style: TextStyle(
                                          fontFamily: bold, color: redColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        10.heightBox,
                        controllar.isLoading.value
                            ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(redColor),
                              )
                            : commonButton(
                                    onPressed: () async {
                                      try {
                                        if (isChecked == true &&
                                            signupValidation(
                                                emailController.text,
                                                passwordController.text,
                                                nameController.text,
                                                confirmPasswordController
                                                    .text)) {
                                          controllar.isLoading(true);
                                          await controllar
                                              .signUpMethod(
                                                  context: context,
                                                  email: emailController.text,
                                                  password:
                                                      passwordController.text)
                                              .then((value) {
                                            return controllar.storeUserData(
                                                email: emailController.text,
                                                password:
                                                    passwordController.text,
                                                name: nameController.text);
                                          }).then((value) {
                                            showMessage(
                                                context: context,
                                                msg: 'Congratulations!');
                                            return Get.offAll(
                                                () => const CusttomNavBar());
                                          });
                                        } else {
                                          controllar.isLoading(false);
                                        }
                                      } catch (e) {
                                        VxToast.show(context,
                                            msg: e.toString());
                                        controllar.signOut();
                                      }
                                    },
                                    bgcolor: isChecked == true
                                        ? redColor
                                        : lightGrey,
                                    title: textsignUp,
                                    textColor: whiteColor)
                                .box
                                .width(context.screenWidth - 50)
                                .make(),
                        10.heightBox,
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: textAlreayHaveAccount,
                                style: TextStyle(
                                    color: fontGrey, fontFamily: bold),
                              ),
                              TextSpan(
                                text: textlogin,
                                style: TextStyle(
                                    color: redColor, fontFamily: bold),
                              ),
                            ],
                          ),
                        ).onTap(
                          () {
                            Get.back();
                          },
                        ),
                      ],
                    )
                        .box
                        .white
                        .rounded
                        .padding(const EdgeInsets.all(16))
                        .width(context.screenWidth - 70)
                        .shadowSm
                        .make(),
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
