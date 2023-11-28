import 'package:emart/common_widget/exit_alert_dialog.dart';
import 'package:emart/controller/nav_bar_controller/nav_bar_controller.dart';
import 'package:emart/views/cart_screen/cart_screen.dart';
import 'package:emart/views/category_screen/categories_screen.dart';
import 'package:emart/views/home_screen/home_screen.dart';
import 'package:emart/views/profile_screen/profile_screen.dart';
import 'package:get/get.dart';
import '../../consts/consts.dart';

class CusttomNavBar extends StatelessWidget {
  const CusttomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    //home controller
    var controller = Get.put(NavBarController());

    // nav bar items
    var navBarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(icHome, width: 26), label: home),
      BottomNavigationBarItem(
          icon: Image.asset(icCategories, width: 26), label: categories),
      BottomNavigationBarItem(
          icon: Image.asset(icCart, width: 26), label: cart),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProfile,
            width: 26,
          ),
          label: account),
    ];

    // temp bottom navbar items screen

    var navBody = [
      HomeScreen(),
      const CatergoryScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];

    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context,
            builder: (context) => alertDialog(context: context));
        return false;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        body: Column(
          children: [
            Obx(() => Expanded(
                child: navBody.elementAt(controller.currentNavIndex.value))),
          ],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            items: navBarItem,
            backgroundColor: whiteColor,
            selectedItemColor: redColor,
            selectedLabelStyle: const TextStyle(fontFamily: semibold),
            type: BottomNavigationBarType.fixed,
            onTap: (value) {
              controller.currentNavIndex.value = value;
            },
          ),
        ),
      ),
    );
  }
}
