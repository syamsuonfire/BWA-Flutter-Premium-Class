import 'package:flutter/material.dart';
import 'package:bwa_cozy/theme.dart';
import 'package:bwa_cozy/models/tips_model.dart';

class TipsWidget extends StatelessWidget {
  final TipsnGuide tips;

  TipsWidget({this.tips});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 20,
      ),
      child: Row(
        children: [
          Image.asset(
            tips.image,
            width: 80,
          ),
          SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tips.title,
                style: medium.copyWith(
                  fontSize: 18,
                ),
              ),
              Text(
                'Updated ${tips.time}',
                style: light.copyWith(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            size: 20,
            color: Color(0xffC9C9C9),
          ),
        ],
      ),
    );
  }
}
