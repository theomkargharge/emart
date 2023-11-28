import 'package:emart/consts/consts.dart';

Widget commonButton(
    {onPressed,
    Color? bgcolor,
    Color? textColor,
    String? title,
    OutlinedBorder? shape}) {
  return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgcolor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 15.0,
      ),
      child: title!.text.color(textColor).fontFamily(bold).make());
}
