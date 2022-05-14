part of 'pages.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            //// Header
            Container(
              margin: EdgeInsets.only(bottom: defaultMargin),
              padding: EdgeInsets.only(bottom: 26),
              width: double.infinity,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 110,
                    width: 110,
                    margin: EdgeInsets.only(top: 26, bottom: 16),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/photo_border.png"),
                          fit: BoxFit.cover),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                          image: DecorationImage(
                              image: ((context.watch<UserCubit>().state as UserLoaded).user.picturePath == "")
                                  ? AssetImage("assets/photo.png")
                                  : NetworkImage((context.watch<UserCubit>().state as UserLoaded).user.picturePath),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  Text((context.watch<UserCubit>().state as UserLoaded).user.name,
                      style: blackFontStyle2.copyWith(fontSize: 18, fontWeight: FontWeight.w500)),
                  SizedBox(height: 6),
                  Text((context.watch<UserCubit>().state as UserLoaded).user.email,
                      style:
                          greyFontStyle.copyWith(fontWeight: FontWeight.w300)),
                ],
              ),
            ),
            //// Body
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: EdgeInsets.only(bottom: 16),
              child: Column(
                children: [
                  CustomTabbar(
                    titles: ["Account", "FoodMarket"],
                    selectedIndex: selectedIndex,
                    onTap: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                      child: (selectedIndex == 0)
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Edit Profile",
                                          style: blackFontStyle3),
                                      SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: Image.asset(
                                            "assets/right_arrow.png"),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () {},
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Home Addresss",
                                          style: blackFontStyle3),
                                      SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: Image.asset(
                                            "assets/right_arrow.png"),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () {},
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Security", style: blackFontStyle3),
                                      SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: Image.asset(
                                            "assets/right_arrow.png"),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () {},
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Payments", style: blackFontStyle3),
                                      SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: Image.asset(
                                            "assets/right_arrow.png"),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () async {
                                    await context.read<UserCubit>().signOut();
                                    Get.offAll(SignInPage());

                                    // if (result == true) {
                                      
                                    // } else {
                                    //   Get.snackbar(
                                    //     "",
                                    //     "",
                                    //     backgroundColor: "D9435E".toColor(),
                                    //     icon: Icon(MdiIcons.closeCircleOutline,
                                    //         color: Colors.white),
                                    //     titleText: Text("Sign Out Faild",
                                    //         style: GoogleFonts.poppins(
                                    //             color: Colors.white,
                                    //             fontWeight: FontWeight.w600)),
                                    //     messageText: Text("Tunggu beberapa saat lagi " + result.toString(), style: GoogleFonts.poppins(color: Colors.white)),);
                                    // }
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Sign Out", style: blackFontStyle3),
                                      SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: Image.asset(
                                            "assets/right_arrow.png"),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Rate App", style: blackFontStyle3),
                                      SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: Image.asset(
                                            "assets/right_arrow.png"),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () {},
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Help Center",
                                          style: blackFontStyle3),
                                      SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: Image.asset(
                                            "assets/right_arrow.png"),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () {},
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Privacy & Policy",
                                          style: blackFontStyle3),
                                      SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: Image.asset(
                                            "assets/right_arrow.png"),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () {},
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Terms & Conditions",
                                          style: blackFontStyle3),
                                      SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: Image.asset(
                                            "assets/right_arrow.png"),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
