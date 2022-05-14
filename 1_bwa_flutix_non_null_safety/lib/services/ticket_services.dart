part of 'services.dart';

class TicketServices {
  static CollectionReference _ticketCollection =
      FirebaseFirestore.instance.collection('tickets');

  static Future<void> saveTicket(String id, Ticket ticket) async {
    await _ticketCollection.doc().set({
      'movieID': ticket.movieDetail.id ?? "",
      'userID': id ?? "",
      'theaterName': ticket.theater.name ?? 0,
      'time': ticket.time.millisecondsSinceEpoch ??
          DateTime.now().millisecondsSinceEpoch,
      'bookingCode': ticket.bookingCode,
      'seats': ticket.seatsInString,
      'name': ticket.name,
      'totalPrice': ticket.totalPrice,
    });
  }

  static Future<List<Ticket>> getTickets(String userID) async {
    QuerySnapshot snapshot =
        await _ticketCollection.where('userID', isEqualTo: userID).get();

    List<Ticket> tickets = [];
    for (var doc in snapshot.docs) {
      MovieDetail movieDetail =
          await MovieServices.getDetail(null, movieID: doc.get('movieID'));
      tickets.add(Ticket(
        movieDetail,
        Theater(doc.get('theaterName')),
        DateTime.fromMillisecondsSinceEpoch(doc.get('time')),
        doc.get('bookingCode'),
        doc.get('seats').toString().split(', '),
        doc.get('name'),
        doc.get('totalPrice'),
      ));
    }

    return tickets;
  }
}
