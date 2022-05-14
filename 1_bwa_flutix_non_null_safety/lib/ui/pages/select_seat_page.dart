part of 'pages.dart';

class SelectSeatPage extends StatefulWidget {
  final Ticket ticket;

  const SelectSeatPage(this.ticket, {Key key}) : super(key: key);

  @override
  _SelectSeatPageState createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  List<String> selectedSeats = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<PageBloc>(context)
            .add(GoToSelectSchedulePage(widget.ticket.movieDetail));
        return;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(color: accentColor1),
            SafeArea(child: Container(color: Colors.white)),
            ListView(
              children: [
                // note: back button
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20, left: defaultMargin),
                      padding: EdgeInsets.all(1),
                      child: GestureDetector(
                        onTap: () {
                          BlocProvider.of<PageBloc>(context).add(
                              GoToSelectSchedulePage(
                                  widget.ticket.movieDetail));
                        },
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, right: defaultMargin),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 16),
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              widget.ticket.movieDetail.title,
                              style: blackTextFont.copyWith(fontSize: 20),
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.end,
                            ),
                          ),
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: NetworkImage(imageBaseURL +
                                    "w154" +
                                    widget.ticket.movieDetail.posterPath),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // note: cinema screen
                Container(
                  margin: EdgeInsets.only(top: 30),
                  width: 277,
                  height: 84,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/screen.png"),
                    ),
                  ),
                ),

                // note: seats
                generateSeats(),

                // note: button next
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.topCenter,
                  child: BlocBuilder<UserBloc, UserState>(
                    builder: (context, userState) {
                      return FloatingActionButton(
                        elevation: 0,
                        backgroundColor: selectedSeats.length > 0
                            ? mainColor
                            : Color(0xFFE4E4E4),
                        child: Icon(
                          Icons.arrow_forward,
                          color: selectedSeats.length > 0
                              ? Colors.white
                              : Colors.black,
                        ),
                        onPressed: selectedSeats.length > 0
                            ? () {
                                BlocProvider.of<PageBloc>(context).add(
                                    GoToCheckoutPage(widget.ticket
                                        .copyWith(seats: selectedSeats)));
                              }
                            : null,
                      );
                    },
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget generateSeats() {
    List<int> numberOfSeats = [3, 5, 5, 5, 5];
    List<Widget> widgets = [];

    for (int i = 0; i < numberOfSeats.length; i++) {
      widgets.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          numberOfSeats[i],
          (index) => Padding(
            padding: EdgeInsets.only(
                left: (index == 0) ? defaultMargin : 0,
                right: (index < numberOfSeats[i] - 1) ? 16 : defaultMargin,
                bottom: 16),
            child: SelectableBox(
              text: "${String.fromCharCode(65 + i)}${index + 1}",
              width: 40,
              height: 40,
              textStyle: whiteNumberFont.copyWith(color: Colors.black),
              isSelected: selectedSeats
                  .contains("${String.fromCharCode(65 + i)}${index + 1}"),
              onTap: () {
                String seatNumber =
                    "${String.fromCharCode(65 + i)}${index + 1}";
                setState(() {
                  if (selectedSeats.contains(seatNumber)) {
                    selectedSeats.remove(seatNumber);
                  } else {
                    selectedSeats.add(seatNumber);
                  }
                });
              },
              isEnabled: index != 0,
            ),
          ),
        ),
      ));
    }

    return Column(children: widgets);
  }
}
