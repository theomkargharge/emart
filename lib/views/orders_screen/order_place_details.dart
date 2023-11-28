import 'package:emart/consts/consts.dart';

Widget orderPlaceDetails({title1, title2, detail1, detail2}) {
  return Padding(
    padding: const EdgeInsets.all(12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            '$title1'.text.fontFamily(semibold).color(darkFontGrey).make(),
            '$detail1'.text.color(redColor).fontFamily(bold).make(),
          ],
        ),
        SizedBox(
          width: 118,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              '$title2'.text.fontFamily(semibold).color(darkFontGrey).make(),
              '$detail2'.text.color(redColor).fontFamily(bold).make(),
            ],
          ),
        )
      ],
    ),
  );
}
