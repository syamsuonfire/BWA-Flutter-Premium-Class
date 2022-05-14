part of 'pages.dart';

class SelectSchedulePage extends StatefulWidget {
  final MovieDetail movieDetail;

  const SelectSchedulePage(this.movieDetail, {Key key}) : super(key: key);

  @override
  _SelectSchedulePageState createState() => _SelectSchedulePageState();
}

class _SelectSchedulePageState extends State<SelectSchedulePage> {
  List<DateTime> dates;
  DateTime selectedDate;
  List<int> schedules = List.generate(7, (index) => 10 + index * 2);
  int selectedTime;
  Theater selectedTheater;
  bool isValid = false;

  @override
  void initState() {
    super.initState();

    dates = List.generate(
      7,
      (index) => DateTime.now().add(Duration(days: index)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<PageBloc>(context)
            .add(GoToMovieDetailPage(widget.movieDetail));
        return;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(color: accentColor1),
            SafeArea(
              child: Container(color: Colors.white),
            ),
            ListView(
              children: [
                // note: back button
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 20, left: defaultMargin),
                  padding: EdgeInsets.all(1),
                  child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<PageBloc>(context)
                          .add(GoToMovieDetailPage(widget.movieDetail));
                    },
                    child: Icon(Icons.arrow_back),
                  ),
                ),

                // note: choose date
                Container(
                  margin:
                      EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 16),
                  child: Text(
                    "Choose Date",
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 24),
                  height: 90,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: dates.length,
                    itemBuilder: (_, index) => Padding(
                      padding: EdgeInsets.only(
                          left: (index == 0) ? defaultMargin : 0,
                          right:
                              (index < dates.length - 1) ? 16 : defaultMargin),
                      child: DateCard(
                        date: dates[index],
                        isSelected: selectedDate == dates[index],
                        onTap: () {
                          setState(() {
                            selectedDate = dates[index];
                            selectedTime = null;
                            isValid = false;
                          });
                        },
                      ),
                    ),
                  ),
                ),

                // note: choose time
                Column(
                  children: dummyTheaters
                      .map(
                        (theater) => Wrap(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  defaultMargin, 0, defaultMargin, 16),
                              child: Text(
                                theater.name,
                                style: blackTextFont.copyWith(fontSize: 20),
                              ),
                            ),
                            Container(
                              height: 50,
                              margin: EdgeInsets.only(bottom: 20),
                              child: ListView.builder(
                                itemCount: schedules.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (_, index) => Padding(
                                  padding: EdgeInsets.only(
                                      left: (index == 0) ? defaultMargin : 0,
                                      right: (index < dates.length - 1)
                                          ? 16
                                          : defaultMargin),
                                  child: SelectableBox(
                                    text: "${schedules[index]}:00",
                                    height: 50,
                                    isSelected: selectedTheater == theater &&
                                        selectedTime == schedules[index],
                                    isEnabled: selectedDate != null &&
                                        (schedules[index] >
                                                DateTime.now().hour ||
                                            selectedDate?.day !=
                                                DateTime.now().day),
                                    onTap: () {
                                      setState(() {
                                        selectedTheater = theater;
                                        selectedTime = schedules[index];
                                        isValid = true;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),

                //note: next button
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.topCenter,
                  child: BlocBuilder<UserBloc, UserState>(
                    builder: (context, userState) {
                      return FloatingActionButton(
                        elevation: 0,
                        backgroundColor:
                            isValid ? mainColor : Color(0xFFE4E4E4),
                        child: Icon(
                          Icons.arrow_forward,
                          color: isValid ? Colors.white : Colors.black,
                        ),
                        onPressed: () {
                          BlocProvider.of<PageBloc>(context).add(
                              GoToSelectSeatPage(Ticket(
                                  widget.movieDetail,
                                  selectedTheater,
                                  DateTime(
                                      selectedDate.year,
                                      selectedDate.month,
                                      selectedDate.day,
                                      selectedTime),
                                  randomAlphaNumeric(12).toUpperCase(),
                                  null,
                                  (userState as UserLoaded).user.name,
                                  null)));
                        },
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
}
