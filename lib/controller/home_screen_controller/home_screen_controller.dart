import 'package:emart/consts/consts.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  @override
  void onInit() {
    getUserName();
    super.onInit();
  }

  var username = '';

  getUserName() async {
    var name = await firestore
        .collection(userCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });
    username = name;
  }
}
