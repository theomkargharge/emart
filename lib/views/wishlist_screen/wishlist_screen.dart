import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/consts.dart';
import '../../common_widget/loadingIndicator.dart';
import '../../services/firestore_services.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title:
            'My Wishlist'.text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreSerives.getWishList(),
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
                      itemBuilder: (context, index) {
                        return Card(
                          color: whiteColor,
                          elevation: 0.2,
                          child: ListTile(
                            leading: Image.network(
                              '${data[index]['images'][0]}',
                              width: 100,
                              fit: BoxFit.cover,
                            ).box.roundedFull.make(),
                            title: '${data[index]['product_name']}'
                                .text
                                .fontFamily(semibold)
                                .make(),
                            subtitle: "\$${data[index]['price']}"
                                .text
                                .fontFamily(semibold)
                                .color(redColor)
                                .make(),
                            trailing: const Icon(
                              Icons.favorite,
                              color: redColor,
                            ).onTap(() async {
                              await firestore
                                  .collection(productCollection)
                                  .doc(data[index].id)
                                  .set({
                                'wishlist':
                                    FieldValue.arrayRemove([currentUser!.uid])
                              }, SetOptions(merge: true));
                            }),
                          ),
                        );
                      }),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
