import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/common_widget/bg_widgets.dart';
import 'package:emart/common_widget/loadingIndicator.dart';
import 'package:emart/controller/product_controller.dart';
import 'package:emart/services/firestore_services.dart';
import 'package:emart/views/category_screen/item_details/item_details.dart';
import 'package:get/get.dart';
import '../../../consts/consts.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;
  const CategoryDetails({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductConroller>();
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: title?.text.white.fontFamily(bold).make(),
        ),
        body: StreamBuilder(
          stream: FirestoreSerives.getProduct(category: title),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: 'Opps you got nothing'
                    .text
                    .color(darkFontGrey)
                    .maxFontSize(16)
                    .make(),
              );
            } else {
              var data = snapshot.data!.docs;
              return Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            controller.subCategories.length,
                            (index) => '${controller.subCategories[index]}'
                                .text
                                .size(12)
                                .fontFamily(semibold)
                                .makeCentered()
                                .box
                                .white
                                .roundedSM
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 4))
                                .size(120, 60)
                                .make()),
                      ),
                    ),
                    20.heightBox,
                    Flexible(
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: data.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                                mainAxisExtent: 250),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Image.network(
                                data[index]['images'][0],
                                width: 200,
                                height: 150,
                                fit: BoxFit.fill,
                              ),
                              10.heightBox,
                              '${data[index]['product_name']}'
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                              10.heightBox,
                              '\$${data[index]["price"]}'
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
                              .margin(const EdgeInsets.symmetric(horizontal: 4))
                              .padding(const EdgeInsets.all(12))
                              .outerShadowSm
                              .make()
                              .onTap(() {
                            controller.checkPInWishList(data: data[index]);
                            Get.to(() => ItemDetails(
                                  title: data[index]['product_name'],
                                  data: data[index],
                                ));
                          });
                        },
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

/*

 
     


 */