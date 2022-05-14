import 'package:airplane/models/transaction_model.dart';
import 'package:airplane/shared/theme.dart';
import 'package:airplane/ui/widgets/item_booking_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transactionModel;
  const TransactionCard(this.transactionModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 30,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: kWhiteColor,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Note destination tile
          Row(
            children: [
              Container(
                width: 70,
                height: 70,
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      transactionModel.destinationModel.imageUrl,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transactionModel.destinationModel.name,
                      style: blackTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: medium,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      transactionModel.destinationModel.city,
                      style: greyTextStyle.copyWith(
                        fontWeight: light,
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    margin: EdgeInsets.only(right: 2),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/icon_star.png',
                        ),
                      ),
                    ),
                  ),
                  Text(
                    transactionModel.destinationModel.rating.toString(),
                    style: blackTextStyle.copyWith(
                      fontWeight: medium,
                    ),
                  ),
                ],
              ),
            ],
          ),

          //Note Booking Detail
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              'Booking Details',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
          ),
          // Note Booking detail item
          ItemBookingDetails(
            title: 'Travelers',
            valueTitle: '${transactionModel.ammountOfTraveler} Person',
            valueColor: kBlackColor,
          ),
          ItemBookingDetails(
            title: 'Seat',
            valueTitle: transactionModel.selectedSeats,
            valueColor: kBlackColor,
          ),
          ItemBookingDetails(
            title: 'Insurance',
            valueTitle: transactionModel.insurance ? 'YES' : 'NO',
            valueColor: transactionModel.insurance ? kGreenColor : kRedColor,
          ),
          ItemBookingDetails(
            title: 'Refundable',
            valueTitle: transactionModel.refundable ? 'YES' : 'NO',
            valueColor: transactionModel.refundable ? kGreenColor : kRedColor,
          ),
          ItemBookingDetails(
            title: 'VAT',
            valueTitle: '${(transactionModel.vat * 100).toStringAsFixed(0)}%',
            valueColor: kBlackColor,
          ),
          ItemBookingDetails(
            title: 'Price',
            valueTitle: NumberFormat.currency(
              locale: 'id',
              symbol: 'IDR ',
              decimalDigits: 0,
            ).format(transactionModel.price),
            valueColor: kBlackColor,
          ),
          ItemBookingDetails(
            title: 'Grand Total',
            valueTitle: NumberFormat.currency(
              locale: 'id',
              symbol: 'IDR ',
              decimalDigits: 0,
            ).format(transactionModel.grandTotal),
            valueColor: kPrimaryColor,
          ),
        ],
      ),
    );
  }
}
