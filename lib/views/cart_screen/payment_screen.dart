import 'package:emart/common_widget/common_toast.dart';
import 'package:emart/common_widget/loadingIndicator.dart';
import 'package:emart/consts/common_list.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/controller/cart_controller/cart_controller.dart';
import 'package:emart/views/custtom_navbar/custtom_navbar.dart';
import 'package:get/get.dart';

class PayentScreen extends StatelessWidget {
  const PayentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();

    return Obx(
      () => Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: SizedBox(
            height: 60,
            child: controller.placingOrder.value
                ? loadingIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      controller.placeMyOrder(
                          orderPaymentMethod: paymentMethodNameList[
                              controller.selectedIndex.value],
                          totalAmount: controller.totalPrice.value);
                      await controller.clearCart();
                      // ignore: use_build_context_synchronously
                      showMessage(
                          context: context, msg: 'Order Placed Successfully');
                      Get.offAll(() => const CusttomNavBar());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: redColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1),
                      ),
                      elevation: 15.0,
                    ),
                    child: 'Place Order'
                        .text
                        .color(whiteColor)
                        .fontFamily(bold)
                        .make())),
        appBar: AppBar(
            title: 'Choose Payment Method'
                .text
                .fontFamily(semibold)
                .size(21)
                .make()),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(
            () => Column(
              children: List.generate(paymentMethodImgList.length, (index) {
                return GestureDetector(
                  onTap: () {
                    controller.isPressed.value = !controller.isPressed.value;
                    controller.selectedIndex.value = index;
                  },
                  child: Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: controller.selectedIndex == index
                                  ? Colors.green
                                  : Colors.transparent,
                              width: 2,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            clipBehavior: Clip.antiAlias,
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Image.asset(
                                  paymentMethodImgList[index],
                                  width: double.infinity,
                                  height: 120,
                                  color: controller.selectedIndex == index
                                      ? Colors.black.withOpacity(0.2)
                                      : Colors.transparent,
                                  colorBlendMode:
                                      controller.selectedIndex == index
                                          ? BlendMode.darken
                                          : BlendMode.color,
                                  fit: BoxFit.cover,
                                ),
                                controller.selectedIndex == index
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: paymentMethodNameList[index]
                                            .text
                                            .fontWeight(FontWeight.bold)
                                            .fontFamily(semibold)
                                            .color(whiteColor)
                                            .make(),
                                      )
                                    : ''.text.make()
                              ],
                            )),
                      )),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
