part of 'pages.dart';

class SuccessOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: IllustrationPage(
          title: "You've Made Order",
          subtitle: "Just stay at home while we are\npreparing your best foods",
          picturePath: 'assets/success_order.png',
          buttonTap1: () {
            Get.offAll(MainPage());
          },
          buttonTitle1: "Order Other Foods",
          buttonTap2: () {
            Get.offAll(MainPage(initialPage: 1,));
          },
          buttonTitle2: "View My Order",
        ));
  }
}
