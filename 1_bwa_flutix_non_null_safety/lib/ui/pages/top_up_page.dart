part of 'pages.dart';

class TopUpPage extends StatefulWidget {
  final PageEvent pageEvent;

  const TopUpPage(this.pageEvent, {Key key}) : super(key: key);

  @override
  _TopUpPageState createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  TextEditingController amountController = TextEditingController(text: "IDR 0");
  int selectedAmount = 0;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ThemeBloc>(context).add(
        ChangeTheme(ThemeData().copyWith(primaryColor: Color(0xFFE4E4E4))));

    List<int> amounts = [
      50000,
      100000,
      150000,
      200000,
      250000,
      500000,
      1000000,
      2500000,
      5000000
    ];
    double cardWidth =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 40) / 3;

    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<PageBloc>(context).add(widget.pageEvent);
        return;
      },
      child: Scaffold(
        body: ListView(children: [
          Stack(children: [
            // note: back area
            SafeArea(
              child: Container(
                margin: EdgeInsets.only(top: 20, left: defaultMargin),
                child: GestureDetector(
                  onTap: () {
                    BlocProvider.of<PageBloc>(context).add(widget.pageEvent);
                  },
                  child: Icon(Icons.arrow_back),
                ),
              ),
            ),

            // note: content
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text("Top Up", style: blackTextFont.copyWith(fontSize: 20)),
                  SizedBox(height: 30),
                  TextField(
                    controller: amountController,
                    decoration: InputDecoration(
                      labelStyle: greyTextFont,
                      labelText: "Amount",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        selectedAmount = value.cleanToInt();
                      });

                      amountController.text = NumberFormat.currency(
                        locale: 'id_ID',
                        symbol: 'IDR ',
                        decimalDigits: 0,
                      ).format(value.cleanToInt());

                      amountController.selection = TextSelection.fromPosition(
                        TextPosition(offset: amountController.text.length),
                      );
                    },
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(top: 20, bottom: 14),
                    child: Text("Choose by Template", style: blackTextFont),
                  ),
                  Wrap(
                    spacing: 20,
                    runSpacing: 14,
                    children: amounts
                        .map((amount) => MoneyCard(
                            amount: amount,
                            width: cardWidth,
                            isSelected: amount == selectedAmount,
                            onTap: () {
                              setState(() {
                                if (amount == selectedAmount) {
                                  selectedAmount = 0;
                                } else {
                                  selectedAmount = amount;
                                }

                                amountController.text = NumberFormat.currency(
                                  locale: 'id_ID',
                                  symbol: 'IDR ',
                                  decimalDigits: 0,
                                ).format(selectedAmount);

                                amountController.selection =
                                    TextSelection.fromPosition(
                                  TextPosition(
                                      offset: amountController.text.length),
                                );
                              });
                            }))
                        .toList(),
                  ),
                  SizedBox(height: 100),
                  SizedBox(
                    width: 250,
                    height: 46,
                    child: BlocBuilder<UserBloc, UserState>(
                      builder: (_, userState) => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          primary: Color(0xFF3E9D9D),
                        ),
                        child: Text(
                          "Top Up My Wallet",
                          style: whiteTextFont.copyWith(
                            fontSize: 16,
                            color: selectedAmount > 0
                                ? Colors.white
                                : Color(0xFFBEBEBE),
                          ),
                        ),
                        onPressed: selectedAmount > 0
                            ? () {
                                BlocProvider.of<PageBloc>(context).add(
                                  GoToSuccessPage(
                                    null,
                                    FlutixTransaction(
                                      userID: (userState as UserLoaded).user.id,
                                      title: "Top Up My Wallet",
                                      amount: selectedAmount,
                                      subtitle:
                                          "${DateTime.now().dayName}, ${DateTime.now().day} ${DateTime.now().monthName} ${DateTime.now().year}",
                                      time: DateTime.now(),
                                    ),
                                  ),
                                );
                              }
                            : null,
                      ),
                    ),
                  ),
                  SizedBox(height: 100),
                ],
              ),
            ),
          ])
        ]),
      ),
    );
  }
}
