import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/consts.dart';
import 'package:intl/intl.dart' as intl;

Widget senderBubble({DocumentSnapshot? data}) {
  var format = data?['created_on'] == null
      ? DateTime.now()
      : data?['created_on'].toDate();
  var time = intl.DateFormat('h:mma').format(format);
  return Container(
    padding: const EdgeInsets.all(12),
    margin: const EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
        color: data?['uid'] == currentUser!.uid ? redColor : golden,
        borderRadius: data?['uid'] == currentUser!.uid
            ? const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20))
            : const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      '${data?['msg']}'.text.white.size(16).make(),
      10.heightBox,
      time.text.color(whiteColor.withOpacity(0.5)).make()
    ]),
  );
}
