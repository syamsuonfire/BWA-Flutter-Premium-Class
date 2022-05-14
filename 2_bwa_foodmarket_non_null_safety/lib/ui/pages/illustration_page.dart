part of 'pages.dart';

class IllustrationPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String picturePath;
  final Function buttonTap1;
  final Function buttonTap2;
  final String buttonTitle1;
  final String buttonTitle2;

  IllustrationPage(
      {@required this.title,
      @required this.subtitle,
      @required this.picturePath,
      @required this.buttonTap1,
      this.buttonTap2,
      @required this.buttonTitle1,
      this.buttonTitle2});
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 150,
          width: 150,
          margin: EdgeInsets.only(bottom: 50),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(picturePath),
            ),
          ),
        ),
        Text(title, style: blackFontStyle3.copyWith(fontSize: 20)),
        SizedBox(height: 6),
        Text(
          subtitle,
          style: greyFontStyle.copyWith(
            fontWeight: FontWeight.w300,
          ),
          textAlign: TextAlign.center,
        ),
        Container(
          margin: EdgeInsets.only(top: 30, bottom: 12),
          width: 200,
          height: 45,
          child: RaisedButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            onPressed: buttonTap1,
            color: mainColor,
            child: Text(buttonTitle1,
                style: blackFontStyle3.copyWith(fontWeight: FontWeight.w500)),
          ),
        ),
        (buttonTap2 == null)
            ? SizedBox()
            : Container(
                margin: EdgeInsets.only(bottom: 12),
                width: 200,
                height: 45,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  onPressed: buttonTap2,
                  color: "8D92A3".toColor(),
                  child: Text(buttonTitle2 ?? 'title',
                      style: blackFontStyle3.copyWith(
                          fontWeight: FontWeight.w500, color: Colors.white)),
                ),
              ),
      ],
    ));
  }
}
