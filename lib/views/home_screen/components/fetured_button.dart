import '../../../consts/consts.dart';

Widget featuredButton({String? title, String? image}) {
  return Row(
    children: [
      Image.asset(
        image!,
        width: 60,
        fit: BoxFit.fill,
      ),
      10.heightBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make()
    ],
  )
      .box
      .width(200)
      .margin(const EdgeInsets.symmetric(horizontal: 4))
      .padding(const EdgeInsets.all(4))
      .white
      .roundedSM
      .outerShadowSm
      .make();
}
