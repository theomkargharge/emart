import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/common_widget/home_screen_common_buttons.dart';
import 'package:emart/common_widget/loadingIndicator.dart';
import 'package:emart/consts/common_list.dart';
import 'package:emart/services/firestore_services.dart';
import 'package:emart/views/category_screen/item_details/item_details.dart';
import 'package:emart/views/home_screen/components/fetured_button.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  TextEditingController searchControllar = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: lightGrey,
      padding: const EdgeInsets.all(12),
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 60,
              color: lightGrey,
              child: TextFormField(
                controller: searchControllar,
                decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    filled: true,
                    border: InputBorder.none,
                    fillColor: whiteColor,
                    hintText: textSearchBar,
                    hintStyle: TextStyle(color: textfieldGrey)),
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Brands images swiper
                    10.heightBox,
                    VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: brandList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(brandList[index], fit: BoxFit.fill)
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      },
                    ),
                    15.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        2,
                        (index) => homeButtons(
                          height: context.screenHeight * 0.15,
                          width: context.screenWidth / 2.5,
                          onPressed: () {},
                          image: index == 0 ? icTodaysDeal : icFlashDeal,
                          title: index == 0 ? texttodyDeal : textflashsale,
                        ),
                      ),
                    ),
                    10.heightBox,
                    VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: secondbrandList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(secondbrandList[index],
                                fit: BoxFit.fill)
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      },
                    ),

                    // Featured Categories
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        3,
                        (index) => homeButtons(
                            height: context.screenHeight * 0.15,
                            width: context.screenWidth / 3.4,
                            onPressed: () {},
                            image: index == 0
                                ? icTopCategories
                                : index == 1
                                    ? icBrands
                                    : icTopSeller,
                            title: index == 0
                                ? texttopCategories
                                : index == 1
                                    ? textbrand
                                    : topSellers),
                      ),
                    ),
                    20.heightBox,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: textFeaturedCategories.text
                          .fontFamily(semibold)
                          .size(18)
                          .make(),
                    ),
                    20.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: List.generate(
                            3,
                            (index) => Column(
                                  children: [
                                    featuredButton(
                                        image: featuredImages1[index],
                                        title: featuredtitle1[index]),
                                    10.heightBox,
                                    featuredButton(
                                        image: featuredImages2[index],
                                        title: featuredtitle2[index])
                                  ],
                                )).toList(),
                      ),
                    ),

                    // Featured Prodcuts
                    20.heightBox,
                    Container(
                      padding: const EdgeInsets.all(12),
                      height: 300,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: redColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          featuredProducts.text.white
                              .fontFamily(bold)
                              .size(18)
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
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 4))
                                    .padding(const EdgeInsets.all(8))
                                    .make(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // third swiper
                    10.heightBox,
                    VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: secondbrandList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(secondbrandList[index],
                                fit: BoxFit.fill)
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      },
                    ),

                    // all products grid view

                    20.heightBox,
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: allProducts.text
                          .color(darkFontGrey)
                          .fontFamily(bold)
                          .size(18)
                          .fontWeight(FontWeight.bold)
                          .make(),
                    ),
                    10.heightBox,
                    StreamBuilder(
                      stream: FirestoreSerives.getAllProducts(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return loadingIndicator();
                        } else if (snapshot.data!.docs.isEmpty) {
                          return const Text('Data is empty');
                        } else {
                          var allProductdata = snapshot.data!.docs;
                          return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: allProductdata.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8,
                                    mainAxisExtent: 300),
                            itemBuilder: (context, index) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                    '${allProductdata[index]['images'][0]}',
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.fill,
                                  ),
                                  10.heightBox,
                                  '${allProductdata[index]['product_name']}'
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                  10.heightBox,
                                  '\$${allProductdata[index]['price']}'
                                      .text
                                      .fontFamily(bold)
                                      .size(16)
                                      .color(redColor)
                                      .make()
                                ],
                              ).box.white.roundedSM.make().onTap(() {
                                Get.to(() => ItemDetails(
                                    title:
                                        '${allProductdata[index]['product_name']}',
                                    data: allProductdata[index]));
                              });
                            },
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
