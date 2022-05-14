part of 'pages.dart';

class GeneralPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function onBackButtonPressed;
  final Widget child;
  final Color backColor;

  GeneralPage(
      {this.title = "Title",
      this.subtitle = "subtitle",
      this.onBackButtonPressed,
      this.child,
      this.backColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          SafeArea(
              child: Container(
            color: backColor ?? Colors.white60
          )),
          SafeArea(
            child: ListView(
              children: [
                Column(
                  children: [
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: defaultMargin),
                        width: double.infinity,
                        height: 100,
                        color: Colors.white,
                        child: Row(
                          children: [
                            onBackButtonPressed != null
                                ? GestureDetector(
                                  onTap: (){
                                    if(onBackButtonPressed != null) {
                                      onBackButtonPressed();
                                    }
                                  },
                                  child: Container(
                                      height: 24,
                                      width: 24,
                                      margin: EdgeInsets.only(right: 26),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage("assets/back_arrow.png")
                                        )
                                      ),
                                    ),
                                )
                                : SizedBox(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(title,
                                    style: GoogleFonts.poppins(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500)),
                                Text(subtitle,
                                    style: GoogleFonts.poppins(
                                        color: greyColor,
                                        fontWeight: FontWeight.w300))
                              ],
                            ),
                          ],
                        )),
                    Container(
                      height: defaultMargin,
                      width: double.infinity,
                      color: "FAFAFC".toColor(),
                    ),
                    child ?? SizedBox()
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
