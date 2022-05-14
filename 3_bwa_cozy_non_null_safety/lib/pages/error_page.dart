import 'package:bwa_cozy/theme.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/404.png',
                width: 300,
              ),
              SizedBox(
                height: 70.05,
              ),
              Text(
                'Where are you going?',
                style: medium.copyWith(
                  fontSize: 24,
                  color: black,
                ),
              ),
              Text(
                'Seems like the page that you were\nrequested is already gone',
                style: light.copyWith(
                  fontSize: 16,
                  color: Color(0xfff82868E),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - (2 * 83),
                  height: 50,
                  decoration: BoxDecoration(
                      color: purple, borderRadius: BorderRadius.circular(17)),
                  child: Center(
                    child: Text(
                      'Back to Home',
                      style: medium.copyWith(
                        fontSize: 18,
                        color: white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
