import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/common_widget/common_button.dart';
import 'package:emart/common_widget/common_toast.dart';
import 'package:emart/common_widget/loadingIndicator.dart';
import 'package:emart/controller/cart_controller/cart_controller.dart';
import 'package:emart/services/firestore_services.dart';
import 'package:emart/views/cart_screen/shipping_screen.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: 'Shopping Cart'
                .text
                .fontFamily(semibold)
                .size(16)
                .color(darkFontGrey)
                .make()),
        body: StreamBuilder(
            stream: FirestoreSerives.getCart(uid: currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return loadingIndicator();
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: 'Cart is empty'
                      .text
                      .color(darkFontGrey)
                      .size(16)
                      .fontFamily(bold)
                      .make(),
                );
              } else {
                var data = snapshot.data!.docs;
                controller.productSnapshot = data;
                controller.calulatePrice(data: data);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Image.network(
                                  '${data[index]['img']}',
                                  width: 100,
                                  fit: BoxFit.cover,
                                ).box.roundedFull.make(),
                                title: '${data[index]['title']}'
                                    .text
                                    .fontFamily(semibold)
                                    .make(),
                                subtitle: " ${data[index]['totolPrice']}"
                                    .numCurrency
                                    .text
                                    .fontFamily(semibold)
                                    .color(redColor)
                                    .make(),
                                trailing: const Icon(
                                  Icons.delete,
                                  color: redColor,
                                ).onTap(() {
                                  FirestoreSerives.deleteCart(
                                      docid: data[index].id);
                                  showMessage(
                                      context: context,
                                      msg: 'Removed From the Cart ');
                                }),
                              );
                            }),
                      ),
                      10.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          'Total Price'
                              .text
                              .fontFamily(semibold)
                              .color(Colors.black)
                              .make(),
                          '${controller.totalPrice.value}'
                              .numCurrency
                              .text
                              .fontFamily(semibold)
                              .color(redColor)
                              .make()
                        ],
                      )
                          .box
                          .roundedSM
                          .color(lightGold)
                          .padding(const EdgeInsets.all(12))
                          .make(),
                      SizedBox(
                        width: double.infinity,
                        height: 70,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Flex(
                            direction: Axis.horizontal,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              commonButton(
                                      bgcolor: redColor,
                                      onPressed: () {},
                                      textColor: whiteColor,
                                      title: 'Go Back')
                                  .box
                                  .width(170)
                                  .height(100)
                                  .make(),
                              commonButton(
                                      bgcolor: golden,
                                      onPressed: () {
                                        Get.to(() => const ShippingDetails());
                                      },
                                      textColor: whiteColor,
                                      title: 'Buy Now')
                                  .box
                                  .width(170)
                                  .height(100)
                                  .make(),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
            }));
  }
}


/*

Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: 'Cart is Empty!'
                    .text
                    .fontFamily(semibold)
                    .color(darkFontGrey)
                    .makeCentered(),
              ),
            ),
            10.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                'Total Price'
                    .text
                    .fontFamily(semibold)
                    .color(Colors.black)
                    .make(),
                '400'
                    .numCurrency
                    .text
                    .fontFamily(semibold)
                    .color(redColor)
                    .make()
              ],
            )
                .box
                .roundedSM
                .color(lightGold)
                .padding(const EdgeInsets.all(12))
                .make(),
            SizedBox(
              width: double.infinity,
              height: 70,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    commonButton(
                            bgcolor: redColor,
                            onPressed: () {},
                            textColor: whiteColor,
                            title: 'Go Back')
                        .box
                        .width(180)
                        .height(100)
                        .make(),
                    commonButton(
                            bgcolor: golden,
                            onPressed: () {},
                            textColor: whiteColor,
                            title: 'Buy Now')
                        .box
                        .width(180)
                        .height(100)
                        .make(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    

 */