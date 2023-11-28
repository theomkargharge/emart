import 'package:emart/common_widget/common_button.dart';
import 'package:emart/consts/consts.dart';
import 'package:flutter/services.dart';

Widget alertDialog({context}) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        'Confirm'.text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        const Divider(),
        10.heightBox,
        'Are you sure you want to exit?'
            .text
            .size(16)
            .color(darkFontGrey)
            .make(),
        25.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            commonButton(
                bgcolor: redColor,
                onPressed: () {
                  SystemNavigator.pop();
                },
                textColor: whiteColor,
                title: 'Yes'),
            commonButton(
                bgcolor: golden,
                onPressed: () {
                  Navigator.pop(context);
                },
                textColor: whiteColor,
                title: 'No'),
          ],
        )
      ],
    ).box.color(lightGrey).padding(const EdgeInsets.all(32)).roundedSM.make(),
  );
}
