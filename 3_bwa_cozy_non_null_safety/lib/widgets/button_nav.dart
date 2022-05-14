import 'package:flutter/material.dart';
import 'package:bwa_cozy/theme.dart';

class ButtonNav extends StatelessWidget {
  final String name;
  final bool isActive;

  ButtonNav({this.name, this.isActive});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        icon(name, isActive),
        Spacer(),
        isActive
            ? Container(
                width: 30,
                height: 2,
                decoration: BoxDecoration(
                  color: purple,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(1000),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  Widget icon(name, isActive) {
    switch (name) {
      case 'home':
        return isActive
            ? Image.asset(
                'assets/icons/home_active.png',
                width: 26,
              )
            : Image.asset(
                'assets/icons/home_nonactive.png',
                width: 26,
              );
      case 'mail':
        return isActive
            ? Image.asset(
                'assets/icons/mail_active.png',
                width: 26,
              )
            : Image.asset(
                'assets/icons/mail_nonactive.png',
                width: 26,
              );
      case 'card':
        return isActive
            ? Image.asset(
                'assets/icons/card_active.png',
                width: 26,
              )
            : Image.asset(
                'assets/icons/card_nonactive.png',
                width: 26,
              );
      case 'fav':
        return isActive
            ? Image.asset(
                'assets/icons/fav_active.png',
                width: 26,
              )
            : Image.asset(
                'assets/icons/fav_nonactive.png',
                width: 26,
              );
      default:
        return Container();
    }
  }
}
