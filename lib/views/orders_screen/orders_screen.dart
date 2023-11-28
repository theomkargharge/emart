import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/common_widget/loadingIndicator.dart';
import 'package:emart/services/firestore_services.dart';
import 'package:emart/views/orders_screen/order_details_screen.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: 'My Orders'.text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreSerives.getAllOrders(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator();
          } else if (snapshot.data!.docs.isEmpty) {
            return 'No Orders yet!'.text.color(darkFontGrey).makeCentered();
          } else {
            var data = snapshot.data!.docs;
            return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: Card(
                      elevation: 0.3,
                      color: whiteColor,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(20),
                        leading: data[index]['orders'] != null &&
                                data[index]['orders'].isNotEmpty &&
                                data[index]['orders'][0]['img'] != null
                            ? Image.network(
                                '${data[index]['orders'][0]['img']}',
                                fit: BoxFit.cover,
                                width: 50,
                              )
                            : Image.asset(
                                'placeholder_image.png'), // Provide a placeholder image
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Order Code: ${data[index]['order_code']}'),
                            Text(
                              'Product Name:${data[index]['orders'][0]['title']}',
                              style: const TextStyle(
                                  color: darkFontGrey,
                                  fontSize: 14,
                                  fontFamily: bold,
                                  fontWeight: FontWeight.bold),
                              maxLines: 2,
                            ),
                            Text(
                              'Total Price: \$${data[index]['order_by_total_price']}',
                              style: const TextStyle(color: redColor),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            Get.to(() => OrderDetails(
                                  data: data[index],
                                ));
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: darkFontGrey,
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
