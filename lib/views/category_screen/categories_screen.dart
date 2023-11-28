import 'package:emart/common_widget/bg_widgets.dart';
import 'package:emart/consts/common_list.dart';
import 'package:emart/controller/product_controller.dart';
import 'package:emart/views/category_screen/category_details/category_details.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';

class CatergoryScreen extends StatelessWidget {
  const CatergoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductConroller());
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: categories.text.fontFamily(bold).white.make(),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: GridView.builder(
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisExtent: 200,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Image.asset(
                      categoriesImage[index],
                      width: 200,
                      height: 130,
                      fit: BoxFit.cover,
                    ),
                    10.heightBox,
                    categoriesList[index]
                        .text
                        .color(darkFontGrey)
                        .align(TextAlign.center)
                        .make()
                  ],
                )
                    .box
                    .white
                    .rounded
                    .outerShadowSm
                    .clip(Clip.antiAlias)
                    .padding(const EdgeInsets.all(6))
                    .make()
                    .onTap(() {
                  controller.getSubCategoires(title: categoriesList[index]);
                  Get.to(() => CategoryDetails(
                        title: categoriesList[index],
                      ));
                });
              }),
        ),
      ),
    );
  }
}
