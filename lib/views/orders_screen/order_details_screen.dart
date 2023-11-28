import 'package:emart/views/orders_screen/order_place_details.dart';
import 'package:emart/views/orders_screen/order_status.dart';
import 'package:intl/intl.dart' as intl;

import '../../consts/consts.dart';

class OrderDetails extends StatelessWidget {
  final dynamic data;
  const OrderDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    // var date = data['order_date'].toDate();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: 'Order Details'
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            orderStatus(
                color: redColor,
                icon: Icons.done,
                title: 'Placed',
                showDone: data['order_placed']),
            orderStatus(
                color: Colors.blue,
                icon: Icons.thumb_up,
                title: 'Confirmed',
                showDone: data['order_confirm']),
            orderStatus(
                color: Colors.yellow,
                icon: Icons.car_crash,
                title: 'On Delivery',
                showDone: data['order_on_delivery']),
            orderStatus(
                color: Colors.purple,
                icon: Icons.done_all_rounded,
                title: 'Delivered',
                showDone: data['order_deliverd']),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
              child: Divider(),
            ),
            10.heightBox,
            Column(
              children: [
                orderPlaceDetails(
                    title1: 'Order Code',
                    detail1: data['order_code'],
                    title2: 'Shipping Method',
                    detail2: data['shipping_method']),
                orderPlaceDetails(
                    title1: 'Order Date',
                    detail1: intl.DateFormat()
                        .add_yMEd()
                        .format(data['order_date'].toDate()),
                    title2: 'Payment Method',
                    detail2: data['payment_method']),
                orderPlaceDetails(
                    title1: 'Payment Status',
                    detail1: 'Unpaid',
                    title2: 'Delivery Status',
                    detail2: 'Order Placed'),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 190,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            'Shipping Address'
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                            '${data['order_by_name']}'.text.make(),
                            '${data['order_by_email']}'.text.make(),
                            '${data['order_by_address']}'.text.make(),
                            '${data['order_by_city']}'.text.make(),
                            '${data['order_by_state']}'.text.make(),
                            '${data['order_by_phone']}'.text.make(),
                            '${data['order_by_pincode']}'.text.make(),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 118,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            'Total Amount'
                                .text
                                .fontFamily(bold)
                                .color(darkFontGrey)
                                .make(),
                            '\$${data['order_by_total_price'].toStringAsFixed(2)}'
                                .text
                                .color(redColor)
                                .fontFamily(bold)
                                .make(),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
                .box
                .shadowMd
                .white
                .roundedSM
                .padding(const EdgeInsets.symmetric(horizontal: 10))
                .margin(const EdgeInsets.symmetric(horizontal: 12))
                .make(),
            10.heightBox,
            'Ordered Product'
                .text
                .size(16)
                .color(darkFontGrey)
                .fontFamily(semibold)
                .makeCentered(),
            10.heightBox,
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(
                data['orders'] != null ? data['orders'].length : 0,
                (index) {
                  if (data['orders'] != null && data['orders'].isNotEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        orderPlaceDetails(
                            title1: data['orders'][index]['title'],
                            detail1: '${data['orders'][index]['quantity']}x',
                            title2: '\$${data['orders'][index]['total_price']}',
                            detail2: 'Refundable'),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: 'Color'.text.make(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 3),
                          child: Container(
                            height: 20,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Color(data['orders'][index]['color']),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            )
                .box
                .shadowSm
                .roundedSM
                .margin(const EdgeInsets.symmetric(horizontal: 16))
                .white
                .make()
          ],
        ),
      ),
    );
  }
}
