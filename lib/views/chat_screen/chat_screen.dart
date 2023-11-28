import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/common_widget/loadingIndicator.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/controller/chat_controller/chat_controller.dart';
import 'package:emart/services/firestore_services.dart';
import 'package:emart/views/chat_screen/components/sender_bubble.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: '${controller.friendName}'.text.fontFamily(bold).size(21).make(),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Obx(
              () => controller.isLoading.value
                  ? loadingIndicator()
                  : Expanded(
                      child: StreamBuilder(
                          stream: FirestoreSerives.getChatMessages(
                              doctId: controller.chatDocId.toString()),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return loadingIndicator();
                            } else if (snapshot.data!.docs.isEmpty) {
                              return Center(
                                child: 'Send a message..'
                                    .text
                                    .color(darkFontGrey)
                                    .make(),
                              );
                            } else {
                              return ListView(
                                  children: snapshot.data!.docs
                                      .mapIndexed((currentValue, index) {
                                var data = snapshot.data!.docs[index];

                                return Align(
                                    alignment: data['uid'] == currentUser!.uid
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: senderBubble(data: data));
                              }).toList());
                            }
                          }),
                    ),
            ),
            10.heightBox,
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.msgController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: textfieldGrey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: textfieldGrey),
                      ),
                      hintText: 'Type a Message....',
                    ),
                  ),
                ),
                Center(
                  child: IconButton(
                      onPressed: () {
                        controller.sendMessage(
                            msg: controller.msgController.text);
                        controller.msgController.clear();
                      },
                      icon: const Icon(
                        Icons.send,
                        color: redColor,
                        weight: 100,
                        size: 45,
                      )),
                )
              ],
            )
                .box
                .height(80)
                .padding(const EdgeInsets.all(12))
                .margin(const EdgeInsets.only(bottom: 10))
                .make(),
          ])),
    );
  }
}
