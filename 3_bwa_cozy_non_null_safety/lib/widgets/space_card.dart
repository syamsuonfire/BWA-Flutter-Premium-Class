import 'package:bwa_cozy/pages/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:bwa_cozy/theme.dart';
import 'package:bwa_cozy/models/space_model.dart';

class SpaceCard extends StatelessWidget {
  final Space space;

  SpaceCard({this.space});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(
                      space: space,
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(
          bottom: 30,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(18)),
              child: Container(
                width: 130,
                height: 110,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Image.network(
                      space.image,
                      width: 130,
                      height: 110,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      width: 70,
                      height: 30,
                      decoration: BoxDecoration(
                        color: purple,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            size: 22,
                            color: orange,
                          ),
                          RichText(
                            text: TextSpan(
                              text: space.rate.toString(),
                              style: medium.copyWith(
                                fontSize: 13,
                                color: white,
                              ),
                              children: [
                                TextSpan(
                                  text: '/5',
                                  style: medium.copyWith(
                                    fontSize: 13,
                                    color: white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  space.name,
                  style: medium.copyWith(
                    fontSize: 18,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: '\$${space.price.toString()}',
                    style: medium.copyWith(
                      color: purple,
                      fontSize: 18,
                    ),
                    children: [
                      TextSpan(
                        text: ' / month',
                        style: light.copyWith(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  '${space.city}, ${space.country}',
                  style: light.copyWith(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
