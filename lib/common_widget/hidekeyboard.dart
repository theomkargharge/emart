import 'package:emart/consts/consts.dart';

void hideKeyboard() {
  return FocusManager.instance.primaryFocus?.unfocus();
}
