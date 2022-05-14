part of 'widgets.dart';

class OrderListItem extends StatelessWidget {
  final Transaction transaction;
  final double itemWidth;

  OrderListItem({@required this.transaction, @required this.itemWidth});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          margin: EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
                image: NetworkImage(transaction.food.picturePath),
                fit: BoxFit.cover),
          ),
        ),
        SizedBox(
          width: itemWidth - 182, // 60 - 12 - 110
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transaction.food.name,
                style: blackFontStyle2,
                overflow: TextOverflow.clip,
                maxLines: 1,
              ),
              Text(
                  "${transaction.quantity} items • " +
                      NumberFormat.currency(
                        symbol: "RP ",
                        decimalDigits: 0,
                        locale: 'id-ID',
                      ).format(transaction.total),
                  style: greyFontStyle.copyWith(fontSize: 13)),
            ],
          ),
        ),
        Container(
          width: 110,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(convertDateTime(transaction.dateTime),
                  style: greyFontStyle.copyWith(
                    fontSize: 12,
                  )),
              (transaction.status == TransactionStatus.cancelled)
                  ? Text("Cancelled",
                      style: GoogleFonts.poppins(
                          color: "D9435E".toColor(), fontSize: 10))
                  : (transaction.status == TransactionStatus.pending)
                      ? Text("Pending",
                          style: GoogleFonts.poppins(
                              color: "D9435E".toColor(), fontSize: 10))
                      : (transaction.status == TransactionStatus.on_delivery)
                          ? Text("On delivery",
                              style: GoogleFonts.poppins(
                                  color: "1ABC9C".toColor(), fontSize: 10))
                          : SizedBox()
            ],
          ),
        ),
      ],
    );
  }

  String convertDateTime(DateTime dateTime) {
    String month;

    switch (dateTime.month) {
      case 1:
        month = "Jan";
        break;
      case 2:
        month = "Feb";
        break;
      case 3:
        month = "Mar";
        break;
      case 4:
        month = "Apr";
        break;
      case 5:
        month = "Mei";
        break;
      case 6:
        month = "Jun";
        break;
      case 7:
        month = "Jul";
        break;
      case 8:
        month = "Aug";
        break;
      case 9:
        month = "Sep";
        break;
      case 10:
        month = "Oct";
        break;
      case 11:
        month = "Nov";
        break;
      default:
        month = "Des";
    }

    return month + " ${dateTime.day}, ${dateTime.hour}:${dateTime.minute}";
  }
}
