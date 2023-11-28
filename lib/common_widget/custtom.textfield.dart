import 'package:emart/consts/consts.dart';
import 'package:flutter/services.dart';

Widget customTextField(
    {String? hintText,
    suffixIcon,
    String? textMessage,
    FocusNode? focusNode,
    TextInputType? keyboardType,
    controller,
    bool? obSecureText,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      textMessage!.text.color(redColor).fontFamily(semibold).size(16).make(),
      5.heightBox,
      TextFormField(
        obscureText: obSecureText ?? false,
        controller: controller,
        validator: validator,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: const TextStyle(
            fontFamily: semibold,
            color: textfieldGrey,
          ),
          isDense: true,
          fillColor: lightGrey,
          filled: true,
          border: InputBorder.none,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: redColor),
          ),
        ),
        focusNode: focusNode,
      ),
      10.heightBox,
    ],
  );
}
