import 'package:emart/common_widget/common_toast.dart';
import 'package:emart/common_widget/custtom.textfield.dart';
import 'package:emart/common_widget/hidekeyboard.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/controller/cart_controller/cart_controller.dart';
import 'package:emart/views/cart_screen/payment_screen.dart';
import 'package:get/get.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controllar = Get.find<CartController>();
    return GestureDetector(
      onTap: () => hideKeyboard(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: 'Shipping info'
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
        ),
        bottomNavigationBar: SizedBox(
            height: 60,
            child: ElevatedButton(
                onPressed: () {
                  if (controllar.addressController.text.isNotEmpty &&
                      controllar.cityController.text.isNotEmpty &&
                      controllar.phoneController.text.isNotEmpty &&
                      controllar.pinCodeController.text.isNotEmpty &&
                      controllar.stateController.text.isNotEmpty) {
                    Get.to(() => const PayentScreen());
                  } else {
                    showMessage(
                        context: context, msg: 'All fields are mandatory ');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: redColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1),
                  ),
                  elevation: 15.0,
                ),
                child:
                    'Buy Now'.text.color(whiteColor).fontFamily(bold).make())),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              customTextField(
                  controller: controllar.addressController,
                  hintText: 'Address',
                  obSecureText: false,
                  textMessage: 'Address'),
              customTextField(
                  controller: controllar.cityController,
                  hintText: 'City',
                  obSecureText: false,
                  textMessage: 'City'),
              customTextField(
                  controller: controllar.stateController,
                  hintText: 'State',
                  obSecureText: false,
                  textMessage: 'State'),
              customTextField(
                  controller: controllar.pinCodeController,
                  hintText: 'Pin Code',
                  obSecureText: false,
                  textMessage: 'Pin Code'),
              customTextField(
                  controller: controllar.phoneController,
                  hintText: 'Phone',
                  obSecureText: false,
                  textMessage: 'Phone'),
            ],
          ),
        ),
      ),
    );
  }
}
