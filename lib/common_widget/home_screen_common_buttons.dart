import 'package:emart/consts/consts.dart';

Widget homeButtons(
    {double? width,
    double? height,
    Function? onPressed,
    String? title,
    String? image}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        image!,
        width: 26,
      ),
      10.heightBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make()
    ],
  ).box.rounded.white.size(width!, height!).shadowSm.make();
}
