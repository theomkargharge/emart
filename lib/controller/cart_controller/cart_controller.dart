import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/controller/home_screen_controller/home_screen_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var addressController = TextEditingController();
  var phoneController = TextEditingController();
  var pinCodeController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();

  var totalPrice = 0.obs;
  var selectedIndex = 0.obs;
  RxBool isPressed = false.obs;
  var placingOrder = false.obs;

/*

 */

  late dynamic productSnapshot;
  calulatePrice({data}) {
    totalPrice.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalPrice.value =
          totalPrice.value + int.parse(data[i]['totolPrice'].toString());
    }
  }

  placeMyOrder({totalAmount, orderPaymentMethod}) async {
    placingOrder(true);
    await getProductDetails();
    await firestore.collection(orderCollection).doc().set({
      'order_code': '223356122',
      'order_date': FieldValue.serverTimestamp(),
      'order_by': currentUser!.uid,
      'order_by_name': Get.put(HomeScreenController()).username,
      'order_by_email': currentUser!.email,
      'order_by_address': addressController.text,
      'order_by_state': stateController.text,
      'order_by_city': cityController.text,
      'order_by_phone': phoneController.text,
      'order_by_pincode': pinCodeController.text,
      'order_by_total_price': totalAmount,
      'order_placed': true,
      'shipping_method': 'Home Delivery',
      'payment_method': orderPaymentMethod,
      'orders': FieldValue.arrayUnion(products),
      'order_confirm': false,
      'order_deliverd': false,
      'order_on_delivery': false,
    });
    placingOrder(false);
  }

  var products = [];
  getProductDetails() {
    products.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      products.add({
        'color': productSnapshot[i]['color'],
        'img': productSnapshot[i]['img'],
        'vender_id': productSnapshot[i]['vender_id'],
        'total_price': productSnapshot[i]['totolPrice'],
        'quantity': productSnapshot[i]['quantity'],
        'title': productSnapshot[i]['title']
      });
    }
  }

  clearCart() {
    for (var i = 0; i < productSnapshot.length; i++) {
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }
}
