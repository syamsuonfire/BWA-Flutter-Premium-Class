part of 'widgets.dart';

class TransactionCard extends StatelessWidget {
  final FlutixTransaction transaction;
  final double width;

  const TransactionCard(this.transaction, this.width, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 90,
          width: 70,
          margin: EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: (transaction.picture != null)
                  ? NetworkImage(imageBaseURL + "w500" + transaction.picture)
                  : AssetImage("assets/bg_topup.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: width - 86,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transaction.title,
                style: blackTextFont.copyWith(fontSize: 18),
                maxLines: 2,
                overflow: TextOverflow.clip,
              ),
              SizedBox(height: 5),
              Text(
                NumberFormat.currency(
                  locale: 'id_ID',
                  symbol: 'IDR ',
                  decimalDigits: 0,
                ).format(transaction.amount.abs()),
                style: whiteNumberFont.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: transaction.amount < 0
                      ? Color(0xFFFF5C83)
                      : Color(0xFF3E9D9D),
                ),
              ),
              SizedBox(height: 5),
              Text(
                transaction.title,
                style: greyTextFont.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
