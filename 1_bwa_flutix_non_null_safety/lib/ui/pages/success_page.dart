part of 'pages.dart';

class SuccessPage extends StatelessWidget {
  final Ticket ticket;
  final FlutixTransaction transaction;

  const SuccessPage(this.ticket, this.transaction, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return;
      },
      child: Scaffold(
        body: FutureBuilder(
          future: ticket != null
              ? processingTicketOrder(context)
              : processingTopUp(context),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(ticket == null
                              ? "assets/top_up_done.png"
                              : "assets/ticket_done.png")),
                    ),
                  ),
                  Text(
                    ticket == null ? "Emmm Yummy!" : "Happy Watching!",
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                  SizedBox(height: 16),
                  Text(
                    ticket == null
                        ? "You have successfully\ntop up the wallet"
                        : "You have successfully\nbought the ticket",
                    textAlign: TextAlign.center,
                    style: blackTextFont.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Container(
                    width: 250,
                    height: 46,
                    margin: EdgeInsets.only(top: 70, bottom: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        primary: mainColor,
                      ),
                      child: Text(
                        ticket == null ? "My Wallet" : "My Tickets",
                        style: whiteTextFont.copyWith(fontSize: 16),
                      ),
                      onPressed: () {
                        if (ticket == null) {
                          BlocProvider.of<PageBloc>(context)
                              .add(GoToWalletPage(GoToMainPage()));
                        } else {
                          BlocProvider.of<PageBloc>(context)
                              .add(GoToMainPage(bottomNavBarIndex: 1));
                        }
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Discover new movie? ",
                        style:
                            greyTextFont.copyWith(fontWeight: FontWeight.w400),
                      ),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<PageBloc>(context)
                              .add(GoToMainPage());
                          return;
                        },
                        child: Text(
                          "Back to Home",
                          style: purpleTextFont,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(accentColor2),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> processingTicketOrder(BuildContext context) async {
    BlocProvider.of<UserBloc>(context).add(Purchase(ticket.totalPrice));
    BlocProvider.of<TicketBloc>(context)
        .add(BuyTicket(ticket, transaction.userID));

    await FlutixTransactionServices.saveTransaction(transaction);
  }

  Future<void> processingTopUp(BuildContext context) async {
    BlocProvider.of<UserBloc>(context).add(TopUp(transaction.amount));

    await FlutixTransactionServices.saveTransaction(transaction);
  }
}
