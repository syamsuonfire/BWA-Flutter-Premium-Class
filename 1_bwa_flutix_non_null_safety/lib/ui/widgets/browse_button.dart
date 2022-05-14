part of 'widgets.dart';

class BrowseButton extends StatelessWidget {
  final String genre;

  const BrowseButton(this.genre, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          margin: EdgeInsets.only(bottom: 4),
          decoration: BoxDecoration(
              color: Color(0xFFEEF1F8), borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: Image.asset(
              "assets/ic_" + genre.toLowerCase() + ".png",
              width: 36,
              height: 36,
            ),
          ),
        ),
        Text(genre, style: blackTextFont.copyWith(fontSize: 13)),
      ],
    );
  }
}
