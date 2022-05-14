part of 'pages.dart';

class TicketPage extends StatefulWidget {
  final bool isExpiredTickets;

  const TicketPage({Key key, this.isExpiredTickets = false}) : super(key: key);

  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  bool isExpiredTickets;

  @override
  void initState(){
    super.initState();
    isExpiredTickets = widget.isExpiredTickets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        // note: content
        BlocBuilder<TicketBloc, TicketState>(
          builder: (context, ticketState) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: TicketViewer(
                isExpiredTickets
                    ? ticketState.tickets
                        .where((ticket) => ticket.time.isBefore(DateTime.now()))
                        .toList()
                    : ticketState.tickets
                        .where(
                            (ticket) => !ticket.time.isBefore(DateTime.now()))
                        .toList(),
              ),
            );
          },
        ),
        // note: header
        Container(
          height: 113,
          color: accentColor1,
        ),
        SafeArea(
          child: ClipPath(
            clipper: HeaderClipper(),
            child: Container(
              height: 113,
              color: accentColor1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 24, bottom: 32),
                    child: Text(
                      "My Tickets",
                      style: whiteTextFont.copyWith(fontSize: 20),
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isExpiredTickets = false;
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              "Newest",
                              style: whiteTextFont.copyWith(
                                fontSize: 16,
                                color: !isExpiredTickets
                                    ? Colors.white
                                    : Color(0xFF6F678E),
                              ),
                            ),
                            SizedBox(height: 15),
                            Container(
                              height: 4,
                              width: MediaQuery.of(context).size.width / 2,
                              color: !isExpiredTickets
                                  ? accentColor2
                                  : Colors.transparent,
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isExpiredTickets = true;
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              "Oldest",
                              style: whiteTextFont.copyWith(
                                fontSize: 16,
                                color: isExpiredTickets
                                    ? Colors.white
                                    : Color(0xFF6F678E),
                              ),
                            ),
                            SizedBox(height: 15),
                            Container(
                              height: 4,
                              width: MediaQuery.of(context).size.width / 2,
                              color: isExpiredTickets
                                  ? accentColor2
                                  : Colors.transparent,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(0, size.height, 20, size.height);
    path.lineTo(size.width - 20, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - 20);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class TicketViewer extends StatelessWidget {
  final List<Ticket> tickets;

  const TicketViewer(this.tickets, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    tickets.sort((a, b) => a.time.compareTo(b.time));

    return ListView.builder(
      itemCount: tickets.length,
      itemBuilder: (_, index) => GestureDetector(
        onTap: () {
          BlocProvider.of<PageBloc>(context)
              .add(GoToTicketDetailPage(tickets[index]));
          return;
        },
        child: Container(
          margin: EdgeInsets.only(top: index == 0 ? 133 : 20),
          child: Row(children: [
            Container(
              width: 70,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(imageBaseURL +
                      "w500" +
                      tickets[index].movieDetail.posterPath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 16),
            SizedBox(
              width: MediaQuery.of(context).size.width - 2 * defaultMargin - 86,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tickets[index].movieDetail.title,
                    style: blackTextFont.copyWith(fontSize: 18),
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                  ),
                  SizedBox(height: 6),
                  Text(
                    tickets[index].movieDetail.genresAndLanguage,
                    style: greyTextFont.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    tickets[index].theater.name,
                    style: greyTextFont.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
