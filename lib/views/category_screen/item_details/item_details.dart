import 'package:emart/common_widget/common_button.dart';
import 'package:emart/common_widget/common_toast.dart';
import 'package:emart/consts/common_list.dart';
import 'package:emart/controller/product_controller.dart';
import 'package:emart/views/chat_screen/chat_screen.dart';
import 'package:get/get.dart';
import '../../../consts/consts.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemDetails({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductConroller>();
    var subdata = data;
    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                controller.resetValues();
                Get.back();
              },
              icon: const Icon(Icons.arrow_back)),
          title: title!.text.color(darkFontGrey).make(),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
            Obx(
              () => IconButton(
                  onPressed: () {
                    if (controller.isFav.value) {
                      controller.removeFromWishList(
                          docId: data.id, context: context);
                    } else {
                      controller.addToWishList(
                          docId: data.id, context: context);
                    }
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: controller.isFav.value ? redColor : Colors.blueGrey,
                  )),
            )
          ],
        ),
        body: Obx(
          () => Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // adding image 3
                        VxSwiper.builder(
                          aspectRatio: 16 / 9,
                          height: 350,
                          viewportFraction: 3.0,
                          autoPlay: true,
                          itemCount: subdata['images'].length,
                          itemBuilder: (context, index) {
                            return Image.network(
                              subdata['images'][index],
                              width: 500,
                              fit: BoxFit.contain,
                            );
                          },
                        ),
                        10.heightBox,
                        '${subdata['product_name']}'
                            .text
                            .size(16)
                            .color(darkFontGrey)
                            .fontFamily(semibold)
                            .make(),
                        10.heightBox,
                        VxRating(
                          value: double.parse(subdata['ratings']),
                          onRatingUpdate: (value) {},
                          normalColor: textfieldGrey,
                          selectImage: golden,
                          count: 5,
                          maxRating: 5,
                          size: 25,
                          stepInt: true,
                        ),
                        10.heightBox,
                        '\$${subdata['price']}'
                            .text
                            .color(redColor)
                            .fontFamily(bold)
                            .size(18)
                            .make(),

                        10.heightBox,
                        Row(
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                'Seller'.text.fontFamily(semibold).white.make(),
                                5.heightBox,
                                '${subdata['seller_name']}'
                                    .text
                                    .fontFamily(semibold)
                                    .size(16)
                                    .color(darkFontGrey)
                                    .make()
                              ],
                            )),
                            const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.message_rounded,
                                color: darkFontGrey,
                              ),
                            ).onTap(() {
                              Get.to(() => const ChatScreen(), arguments: [
                                data['seller_name'],
                                data['vender_id']
                              ]);
                            }),
                          ],
                        )
                            .box
                            .color(textfieldGrey)
                            .padding(const EdgeInsets.symmetric(horizontal: 16))
                            .height(70)
                            .make(),

                        // color sectioin
                        20.heightBox,
                        Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: 'Color: '
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                ),
                                Row(
                                  children: List.generate(
                                      subdata['color'].length,
                                      (index) => Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              VxBox()
                                                  .size(40, 40)
                                                  .roundedFull
                                                  .color(Color(
                                                      subdata['color'][index]))
                                                  .margin(const EdgeInsets
                                                      .symmetric(horizontal: 4))
                                                  .make()
                                                  .onTap(() {
                                                controller.chagneColorIndex(
                                                    index: index);
                                              }),
                                              Visibility(
                                                  visible: index ==
                                                      controller
                                                          .colorIndex.value,
                                                  child: const Icon(
                                                    Icons.done,
                                                    color: Colors.white,
                                                  ))
                                            ],
                                          )),
                                )
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),

                            // quanitity row
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: 'Quantity: '
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          controller.decrement();
                                          controller.calculatedtotalPrice(
                                              price:
                                                  int.parse(subdata['price']));
                                        },
                                        icon: const Icon(Icons.remove)),
                                    controller.qty.value.text
                                        .size(16)
                                        .color(darkFontGrey)
                                        .fontFamily(bold)
                                        .make(),
                                    IconButton(
                                        onPressed: () {
                                          controller.increment(
                                              totalQuantity: int.parse(
                                                  subdata['quantity']));
                                          controller.calculatedtotalPrice(
                                              price:
                                                  int.parse(subdata['price']));
                                        },
                                        icon: const Icon(Icons.add)),
                                    10.widthBox,
                                    '${subdata['quantity']} available'
                                        .text
                                        .color(textfieldGrey)
                                        .make()
                                  ],
                                ),
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),

                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: 'Total: '
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                ),
                                '\$ ${controller.totolPrice.value}.00'
                                    .text
                                    .color(redColor)
                                    .size(16)
                                    .fontFamily(bold)
                                    .make()
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),
                          ],
                        ).box.white.shadowSm.make(),

                        10.heightBox,
                        'Specifications'
                            .text
                            .color(darkFontGrey)
                            .fontFamily(semibold)
                            .make(),
                        10.heightBox,
                        '${subdata['Description']}'
                            .text
                            .color(darkFontGrey)
                            .make(),

                        //Buttons section
                        ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: List.generate(
                              itemScreenList.length,
                              (index) => ListTile(
                                    title: itemScreenList[index]
                                        .text
                                        .semiBold
                                        .make(),
                                    trailing:
                                        const Icon(Icons.arrow_forward_ios),
                                  )),
                        ),
                        10.heightBox,
                        textProductYouMayLike.text
                            .fontFamily(bold)
                            .size(16)
                            .color(darkFontGrey)
                            .make(),
                        10.heightBox,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            children: List.generate(
                              6,
                              (index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    imgP1,
                                    width: 150,
                                    fit: BoxFit.fill,
                                  ),
                                  10.heightBox,
                                  'Laptop 4GB/64GB'
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                  10.heightBox,
                                  '\$999.00'
                                      .text
                                      .fontFamily(bold)
                                      .size(16)
                                      .color(redColor)
                                      .make()
                                ],
                              )
                                  .box
                                  .white
                                  .roundedSM
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 4))
                                  .padding(const EdgeInsets.all(8))
                                  .make(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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
                              onPressed: () {
                                if (controller.qty.value > 0) {
                                  controller.addToCart(
                                    color: subdata['color']
                                        [controller.colorIndex.value],
                                    venderId: subdata['vender_id'],
                                    context: context,
                                    img: subdata['images'][0],
                                    qty: controller.qty.value,
                                    sellerName: subdata['seller_name'],
                                    title: subdata['product_name'],
                                    totalPrice: controller.totolPrice.value,
                                  );
                                  showMessage(
                                      context: context, msg: 'Added to Cart');
                                } else {
                                  showMessage(
                                      context: context,
                                      msg: "Quantity can't be zero");
                                }
                              },
                              textColor: whiteColor,
                              title: 'Add to Cart')
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
      ),
    );
  }
}
