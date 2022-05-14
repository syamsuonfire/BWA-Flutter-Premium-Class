part of 'pages.dart';

class WalletPage extends StatelessWidget {
  final PageEvent pageEvent;

  const WalletPage(this.pageEvent, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<PageBloc>(context).add(pageEvent);
        return;
      },
      child: Scaffold(
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, userState) {
            if (userState is UserLoaded) {
              return ListView(children: [
                Stack(children: [
                  // note: back area
                  SafeArea(
                    child: Container(
                      margin: EdgeInsets.only(top: 20, left: defaultMargin),
                      child: GestureDetector(
                        onTap: () {
                          BlocProvider.of<PageBloc>(context).add(pageEvent);
                        },
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Text("MyWallet",
                            style: blackTextFont.copyWith(fontSize: 20)),
                      ],
                    ),
                  ),
                ]),

                // note: id card
                Container(
                  height: 185,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: defaultMargin,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xFF382A74),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        spreadRadius: 0,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Stack(children: [
                    ClipPath(
                      clipper: CardReflectionClipper(),
                      child: Container(
                        height: 185,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.1),
                              Colors.white.withOpacity(0)
                            ],
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              spreadRadius: 0,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Container(
                              width: 18,
                              height: 18,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFFFF2CB),
                              ),
                            ),
                            SizedBox(width: 4),
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: accentColor2,
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  icon: Icon(MdiIcons.walletPlus),
                                  color: Colors.white,
                                  onPressed: () {
                                    BlocProvider.of<PageBloc>(context).add(
                                        GoToTopUpPage(
                                            GoToWalletPage(pageEvent)));
                                  },
                                ),
                              ),
                            ),
                          ]),
                          // note: nominal
                          Text(
                            NumberFormat.currency(
                              locale: 'id_ID',
                              symbol: 'IDR ',
                              decimalDigits: 0,
                            ).format(userState.user.balance),
                            style: whiteNumberFont.copyWith(
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          // note: card holder
                          Row(children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Card Holder",
                                  style: whiteTextFont.copyWith(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Row(children: [
                                  Text(
                                    (userState as UserLoaded).user.name,
                                    style: whiteTextFont.copyWith(
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  SizedBox(
                                    height: 14,
                                    width: 14,
                                    child: Image.asset("assets/ic_check.png"),
                                  )
                                ])
                              ],
                            ),
                            SizedBox(width: 30),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Card ID",
                                  style: whiteTextFont.copyWith(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Row(children: [
                                  Text(
                                    (userState as UserLoaded)
                                        .user
                                        .id
                                        .substring(0, 10)
                                        .toUpperCase(),
                                    style: whiteNumberFont.copyWith(
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  SizedBox(
                                    height: 14,
                                    width: 14,
                                    child: Image.asset("assets/ic_check.png"),
                                  )
                                ])
                              ],
                            ),
                          ]),
                        ],
                      ),
                    ),
                  ]),
                ),

                // note: recent transaction
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: Text(
                    "Recent Transaction",
                    style: blackTextFont,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultMargin,
                    vertical: 12,
                  ),
                  child: FutureBuilder(
                    future: FlutixTransactionServices.getTransactions(
                        userState.user.id),
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        return generateTransactionList(
                            snapshot.data,
                            MediaQuery.of(context).size.width -
                                2 * defaultMargin);
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(mainColor),
                          ),
                        );
                      }
                    },
                  ),
                ),

                // note: button
                SizedBox(height: 75),
              ]);
            } else {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(mainColor),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Column generateTransactionList(
      List<FlutixTransaction> transactions, double width) {
    transactions.sort((a, b) => b.time.compareTo(a.time));
    return Column(
      children: transactions
          .map((e) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: TransactionCard(e, width),
              ))
          .toList(),
    );
  }
}

class CardReflectionClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - 15);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
