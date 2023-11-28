import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/common_widget/loadingIndicator.dart';
import 'package:emart/views/chat_screen/chat_screen.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';
import '../../services/firestore_services.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title:
            'My Messages'.text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreSerives.getAllMessage(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator();
          } else if (snapshot.data!.docs.isEmpty) {
            return 'No Orders yet!'.text.color(darkFontGrey).makeCentered();
          } else {
            var data = snapshot.data!.docs;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: ((context, index) {
                      return Card(
                        color: whiteColor,
                        elevation: 0.3,
                        child: ListTile(
                          onTap: () {
                            Get.to(() => const ChatScreen(), arguments: [
                              data[index]['friend_name'],
                              data[index]['toId'],
                            ]);
                          },
                          leading: const CircleAvatar(
                              backgroundColor: redColor,
                              child: Icon(
                                Icons.person,
                                color: whiteColor,
                              )),
                          title: '${data[index]['friend_name']}'
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                          subtitle: '${data[index]['last_msg']}'
                              .text
                              .fontFamily(semibold)
                              .make(),
                        ),
                      );
                    }),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
