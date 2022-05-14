part of 'widgets.dart';

class RatingStars extends StatelessWidget {
  final double voteAverage;
  final double starSize;
  final double fontSize;
  final Color color;
  final MainAxisAlignment alignment;

  const RatingStars(
      {Key key,
      this.voteAverage = 0,
      this.starSize = 20,
      this.fontSize = 12,
      this.color,
      this.alignment = MainAxisAlignment.start})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int n = (voteAverage / 2).round();

    List<Widget> widgets = List.generate(
      5,
      (index) => Icon(
        (index < n || color != null) ? MdiIcons.star : MdiIcons.starOutline,
        color: (index < n) ? accentColor2 : (color ?? accentColor2),
        size: starSize,
      ),
    );

    widgets.add(SizedBox(width: 3));
    widgets.add(Text(
      "$voteAverage/10",
      style: whiteNumberFont.copyWith(
        fontWeight: FontWeight.w300,
        fontSize: fontSize,
        color: color ?? Colors.white,
      ),
    ));
    return Row(children: widgets, mainAxisAlignment: alignment);
  }
}
