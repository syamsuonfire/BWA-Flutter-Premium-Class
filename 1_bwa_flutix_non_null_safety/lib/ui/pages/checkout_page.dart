part of 'pages.dart';

class CheckoutPage extends StatefulWidget {
  final Ticket ticket;

  const CheckoutPage(this.ticket, {Key key}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    int total = 26500 * widget.ticket.seats.length;

    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<PageBloc>(context)
            .add(GoToSelectSeatPage(widget.ticket));
        return;
      },
      child: Scaffold(
        body: Stack(children: [
          Container(color: accentColor1),
          SafeArea(child: Container(color: Colors.white)),
          ListView(children: [
            // note: back button
            Padding(
              padding: EdgeInsets.only(
                  top: 21, left: defaultMargin + 1, right: defaultMargin + 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<PageBloc>(context)
                          .add(GoToSelectSeatPage(widget.ticket));
                    },
                    child: Icon(Icons.arrow_back),
                  ),
                  Text(
                    "Checkout Page",
                    style: blackTextFont.copyWith(fontSize: 20),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(width: 26),
                ],
              ),
            ),
            SizedBox(height: 30),
            BlocBuilder<UserBloc, UserState>(
              builder: (_, userState) {
                AppUser user = (userState as UserLoaded).user;

                return Column(children: [
                  Row(children: [
                    Container(
                      width: 80,
                      height: 90,
                      margin: EdgeInsets.only(left: defaultMargin, right: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(imageBaseURL +
                              "w342" +
                              widget.ticket.movieDetail.posterPath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          2 * defaultMargin -
                          90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.ticket.movieDetail.title,
                            style: blackTextFont.copyWith(fontSize: 18),
                            maxLines: 2,
                            overflow: TextOverflow.clip,
                          ),
                          Text(widget.ticket.movieDetail.genresAndLanguage),
                          RatingStars(
                            voteAverage: widget.ticket.movieDetail.voteAverage,
                            color: accentColor3,
                          ),
                        ],
                      ),
                    ),
                  ]),
                  // note: Info
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: defaultMargin,
                    ),
                    child: Divider(
                      color: Color(0xFFE4E4E4),
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Order ID",
                          style: greyTextFont.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.55,
                          child: Text(
                            widget.ticket.bookingCode,
                            textAlign: TextAlign.end,
                            style: whiteNumberFont.copyWith(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 9),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Cinema",
                          style: greyTextFont.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.55,
                          child: Text(
                            widget.ticket.theater.name,
                            textAlign: TextAlign.end,
                            style: whiteNumberFont.copyWith(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 9),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Date & Time",
                          style: greyTextFont.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.55,
                          child: Text(
                            widget.ticket.time.dateAndTime,
                            textAlign: TextAlign.end,
                            style: whiteNumberFont.copyWith(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 9),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Seat Numbers",
                          style: greyTextFont.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.55,
                          child: Text(
                            widget.ticket.seatsInString,
                            textAlign: TextAlign.end,
                            style: whiteNumberFont.copyWith(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 9),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Price",
                          style: greyTextFont.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.55,
                          child: Text(
                            "IDR 25.000 x ${widget.ticket.seats.length}",
                            textAlign: TextAlign.end,
                            style: whiteNumberFont.copyWith(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 9),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Fee",
                          style: greyTextFont.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.55,
                          child: Text(
                            "IDR 1.500 x ${widget.ticket.seats.length}",
                            textAlign: TextAlign.end,
                            style: whiteNumberFont.copyWith(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 9),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: greyTextFont.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.55,
                          child: Text(
                            NumberFormat.currency(
                              locale: "id_ID",
                              decimalDigits: 0,
                              symbol: "IDR ",
                            ).format(total),
                            textAlign: TextAlign.end,
                            style: whiteNumberFont.copyWith(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: defaultMargin,
                    ),
                    child: Divider(
                      color: Color(0xFFE4E4E4),
                      thickness: 1,
                    ),
                  ),

                  // note: your wallet
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Your Wallet",
                          style: greyTextFont.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.55,
                          child: Text(
                            NumberFormat.currency(
                              locale: "id_ID",
                              decimalDigits: 0,
                              symbol: "IDR ",
                            ).format(user.balance),
                            textAlign: TextAlign.end,
                            style: whiteNumberFont.copyWith(
                              color: user.balance >= total
                                  ? Color(0xFF3E9D9D)
                                  : Color(0xFFFF5C83),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // note: proceed
                  Container(
                    width: 250,
                    height: 46,
                    margin: EdgeInsets.only(top: 36, bottom: 50),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        primary: user.balance >= total
                            ? Color(0xFF3E9D9D)
                            : mainColor,
                      ),
                      child: Text(
                        user.balance >= total
                            ? "Checkout Now"
                            : "Top Up My Wallet",
                        style: whiteTextFont.copyWith(fontSize: 16),
                      ),
                      onPressed: () {
                        if (user.balance >= total) {
                          FlutixTransaction transaction = FlutixTransaction(
                              userID: user.id,
                              title: widget.ticket.movieDetail.title,
                              subtitle: widget.ticket.theater.name,
                              time: DateTime.now(),
                              amount: -total,
                              picture: widget.ticket.movieDetail.posterPath);

                          BlocProvider.of<PageBloc>(context).add(
                              GoToSuccessPage(
                                  widget.ticket.copyWith(totalPrice: total),
                                  transaction));
                        } else {
                          // uang tidak cukup
                        }
                      },
                    ),
                  ),
                ]);
              },
            ),
          ]),
        ]),
      ),
    );
  }
}
