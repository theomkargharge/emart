// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/auth_screen/login_screen/login_screen.dart';
import 'package:emart/common_widget/bg_widgets.dart';
import 'package:emart/common_widget/common_toast.dart';
import 'package:emart/common_widget/loadingIndicator.dart';
import 'package:emart/consts/common_list.dart';
import 'package:emart/controller/firebase_controller/auth_controller.dart';
import 'package:emart/controller/profile_controller/profile_controller.dart';
import 'package:emart/services/firestore_services.dart';
import 'package:emart/views/chat_screen/messging_screen.dart';
import 'package:emart/views/orders_screen/orders_screen.dart';
import 'package:emart/views/profile_screen/components/details_card.dart';
import 'package:emart/views/profile_screen/edit_profile_screen.dart';
import 'package:get/get.dart';
import '../../consts/consts.dart';
import '../wishlist_screen/wishlist_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var profileContoller = Get.put(ProfileController());
    var controller = Get.put(AuthController());

    return bgWidget(
        child: Scaffold(
            body: StreamBuilder(
                stream: FirestoreSerives.getUser(currentUser!.uid),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    // Handle the error case here.
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    // Handle the case where there is no data in the snapshot.
                    return const Center(child: Text('No data available'));
                  } else {
                    var data = snapshot.data!.docs[0];

                    var name = data['name'];
                    var email = data['email'];
                    var imageUrl = data['imageUrl'];

                    return SafeArea(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: whiteColor,
                                )
                              ],
                            ).onTap(() {
                              profileContoller.nameController.text = name;

                              Get.to(() => EditProfileScreen(
                                    data: data,
                                  ));
                            }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: imageUrl == ''
                                  ? Image.asset(
                                      imgProfile2,
                                      width: 80,
                                    )
                                      .box
                                      .roundedFull
                                      .clip(Clip.antiAlias)
                                      .make()
                                  : Image.network(
                                      imageUrl,
                                      width: 80,
                                    )
                                      .box
                                      .roundedFull
                                      .clip(Clip.antiAlias)
                                      .make(),
                              title: "$name"
                                  .text
                                  .fontFamily(semibold)
                                  .color(textfieldGrey)
                                  .make(),
                              subtitle: "$email"
                                  .text
                                  .fontFamily(semibold)
                                  .size(12)
                                  .make(),
                              trailing: TextButton(
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: redColor,
                                ),
                                onPressed: () async {
                                  await controller.signOut(context: context);
                                  Get.offAll(() => const LoginScreen());
                                  showMessage(
                                      context: context,
                                      msg: 'SignOut Successfully');
                                  // return Get.offAll(const LoginScreen());
                                },
                                child: const Text(
                                  'Logout',
                                  style: TextStyle(color: whiteColor),
                                ),
                              ),
                            ),
                          ),
                          20.heightBox,
                          FutureBuilder(
                            future: FirestoreSerives.getCounts(),
                            builder: ((BuildContext context,
                                AsyncSnapshot snapshot) {
                              if (!snapshot.hasData) {
                                return loadingIndicator();
                              } else {
                                var countdata = snapshot.data;
                                var cartCount = countdata[0];
                                var whishListCount = countdata[1];
                                var orderCount = countdata[2];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      detailsCard(
                                          width: context.screenWidth / 3.31,
                                          title: 'in your cart',
                                          count: cartCount.toString()),
                                      detailsCard(
                                          width: context.screenWidth / 3.31,
                                          title: 'in your wishlist',
                                          count: whishListCount.toString()),
                                      detailsCard(
                                          width: context.screenWidth / 3.31,
                                          title: 'in your order',
                                          count: orderCount.toString()),
                                    ],
                                  ),
                                );
                              }
                            }),
                          ),
                          ListView.separated(
                                  shrinkWrap: true,
                                  itemBuilder: ((context, index) {
                                    return ListTile(
                                      onTap: () {
                                        switch (index) {
                                          case 0:
                                            Get.to(() => const OrderScreen());
                                            break;
                                          case 1:
                                            Get.to(
                                                () => const WishListScreen());
                                            break;
                                          case 2:
                                            Get.to(() => const MessageScreen());
                                            break;
                                        }
                                      },
                                      title: profileButtonList[index]
                                          .text
                                          .color(darkFontGrey)
                                          .fontFamily(semibold)
                                          .make(),
                                    );
                                  }),
                                  separatorBuilder: ((context, index) {
                                    return const Divider(
                                      color: lightGrey,
                                      thickness: 2,
                                    );
                                  }),
                                  itemCount: profileButtonList.length)
                              .box
                              .rounded
                              .margin(const EdgeInsets.all(12))
                              .color(whiteColor)
                              .width(context.screenWidth)
                              .shadowSm
                              .make()
                              .box
                              .color(redColor)
                              .make()
                        ],
                      ),
                    );
                  }
                }) //     })),
            ));
  }
}

/**
             

        
             */
