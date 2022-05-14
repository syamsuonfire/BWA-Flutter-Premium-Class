import 'package:flutter/material.dart';
import 'package:bwa_cozy/theme.dart';
import 'package:bwa_cozy/models/city_model.dart';

class CityCard extends StatelessWidget {
  final City city;
  CityCard(this.city);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: 20,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              width: 120,
              height: 150,
              color: lightGrey,
              child: Column(
                children: [
                  Image.asset(
                    city.image,
                    width: 120,
                    height: 102,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  Text(
                    city.name,
                    style: medium.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            city.isPopular
                ? Container(
                    width: 50,
                    height: 30,
                    decoration: BoxDecoration(
                      color: purple,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                      ),
                    ),
                    child: Icon(
                      Icons.star,
                      size: 22,
                      color: orange,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
