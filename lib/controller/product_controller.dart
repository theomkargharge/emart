import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/common_widget/common_toast.dart';
import 'package:emart/consts/firebase_constant.dart';
import 'package:emart/models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductConroller extends GetxController {
  var isFav = false.obs;
  var qty = 0.obs;
  var colorIndex = 0.obs;
  var totolPrice = 0.obs;
  var subCategories = [];
  getSubCategoires({title}) async {
    subCategories.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var jsonDecoded = categoryModelFromJson(data);
    var subCat = jsonDecoded.categories
        .where((element) => element.name == title)
        .toList();

    for (var e in subCat[0].subcategory) {
      subCategories.add(e);
    }
  }

  increment({totalQuantity}) {
    if (qty.value < totalQuantity) {
      qty.value++;
    }
  }

  chagneColorIndex({index}) {
    colorIndex.value = index;
  }

  decrement() {
    if (qty.value > 0) {
      qty.value--;
    }
  }

  calculatedtotalPrice({price}) {
    totolPrice.value = price * qty.value;
  }

  addToCart(
      {title,
      color,
      img,
      sellerName,
      qty,
      totalPrice,
      venderId,
      context}) async {
    firestore.collection(cartCollection).doc().set({
      'title': title,
      'color': color,
      'img': img,
      'vender_id': venderId,
      'sellerName': sellerName,
      'quantity': qty,
      'totolPrice': totalPrice,
      'added_by': currentUser!.uid
    }).catchError((error) {
      showMessage(context: context, msg: error.toString());
    });
  }

  resetValues() {
    qty.value = 0;
    colorIndex.value = 0;
    totolPrice.value = 0;
    isFav.value = false;
  }
  // add wishlist

  addToWishList({docId, context}) async {
    await firestore.collection(productCollection).doc(docId).set({
      'wishlist': FieldValue.arrayUnion([currentUser!.uid]),
    }, SetOptions(merge: true));
    isFav(true);
    showMessage(context: context, msg: 'Added in WishList');
  }

  removeFromWishList({docId, context}) async {
    await firestore.collection(productCollection).doc(docId).set({
      'wishlist': FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(false);

    showMessage(context: context, msg: 'Remove from WishList');
  }

  checkPInWishList({data}) async {
    if (data['wishlist'].contains(currentUser!.uid)) {
      isFav(true);
    } else {
      isFav(false);
    }
  }
}
