import 'package:emart/auth_screen/sign_up_screen/sign_up_screen.dart';
import 'package:emart/common_widget/applogo_widget.dart';
import 'package:emart/common_widget/bg_widgets.dart';
import 'package:emart/common_widget/common_button.dart';
import 'package:emart/common_widget/common_toast.dart';
import 'package:emart/common_widget/custtom.textfield.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/consts/common_list.dart';
import 'package:emart/controller/firebase_controller/auth_controller.dart';
import 'package:emart/controller/login_controller/login_controller.dart';

import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isShowPassword = true;
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  var controller = Get.put(AuthController());

  var loginContoller = Get.put(LoginController());

  bool loginValidation(String email, String password) {
    if (email.isEmpty && password.isEmpty) {
      showMessage(context: context, msg: 'Both fields are empty');
      return false;
    } else if (email.isEmpty) {
      showMessage(context: context, msg: 'Email fields are empty');
      return false;
    } else if (password.isEmpty) {
      showMessage(context: context, msg: 'password fields are empty');
      return false;
    } else if (!isValidEmail(email)) {
      showMessage(context: context, msg: 'Email is not in valid form');
      return false;
    } else {
      return true;
    }
  }

  bool isValidEmail(String email) {
    // Simple email validation using regex
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  String isValidPassword(String value) {
    if (value.isEmpty) {
      return showMessage(context: context, msg: "Password can't be empty");
    } else if (value.length < 6 || value.length > 10) {
      return showMessage(
          context: context,
          msg:
              "password must have at least 6 characters and maximum of 10 characters");
    } else if (!RegExp(
            r'^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[!@#$%^&*()_+])[a-zA-Z0-9!@#$%^&*()_+]+$')
        .hasMatch(value)) {
      return showMessage(
          context: context,
          msg:
              'password must contain at least one digit, one special character, and Letters');
    }
    return '';
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
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  (context.screenHeight * 0.1).heightBox,
                  applogoWidget(),
                  10.heightBox,
                  'Log in to $appname'
                      .text
                      .fontFamily(bold)
                      .white
                      .size(22)
                      .make(),
                  15.heightBox,
                  Obx(
                    () => Column(
                      children: [
                        customTextField(
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email address,';
                              } else if (isValidEmail(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            hintText: hintEmail,
                            textMessage: email,
                            controller: emailController),
                        customTextField(
                            keyboardType: TextInputType.text,
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
                                loginContoller.isShowPassword.value =
                                    !loginContoller.isShowPassword.value;
                              },
                              child: Icon(loginContoller.isShowPassword.value
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                            hintText: hintPassword,
                            textMessage: password,
                            controller: passwordController,
                            obSecureText: !loginContoller.isShowPassword.value),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(),
                              child: forgotPass.text.make()),
                        ),
                        5.heightBox,
                        controller.isLoading.value
                            ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(redColor),
                              )
                            : commonButton(
                                    onPressed: () async {
                                      try {
                                        if (loginValidation(
                                            emailController.text,
                                            passwordController.text)) {
                                          controller.isLoading(true);
                                          await controller
                                              .loginMethod(
                                                  context: context,
                                                  email: emailController.text,
                                                  password:
                                                      passwordController.text)
                                              .then((value) {
                                            showMessage(
                                                context: context,
                                                msg: 'Logged In');
                                            controller.isLoading(false);
                                          });
                                        } else {
                                          controller.isLoading(false);
                                        }
                                      } catch (e) {
                                        VxToast.show(context,
                                            msg: e.toString(), showTime: 2);
                                        return Get.offAll(
                                            () => const SignUpScreen());
                                        controller.isLoading(false);
                                      }
                                    },
                                    bgcolor: redColor,
                                    title: textlogin,
                                    textColor: whiteColor)
                                .box
                                .width(context.screenWidth - 50)
                                .make(),
                        5.heightBox,
                        textmessagecreateNewAccount.text.color(fontGrey).make(),
                        5.heightBox,
                        commonButton(
                                bgcolor: lightGold,
                                onPressed: () {
                                  Get.to(() => const SignUpScreen());
                                },
                                textColor: redColor,
                                title: textsignUp)
                            .box
                            .width(context.screenWidth - 50)
                            .make(),
                        10.heightBox,
                        textloginWith.text.color(fontGrey).make(),
                        5.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            3,
                            (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: lightGrey,
                                radius: 25,
                                child: Image.asset(
                                  socialIconsList[index],
                                  width: 30,
                                ),
                              ),
                            ),
                          ),
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
