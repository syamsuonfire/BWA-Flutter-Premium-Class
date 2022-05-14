import 'package:bwa_cozy/models/city_model.dart';
import 'package:bwa_cozy/models/space_model.dart';
import 'package:bwa_cozy/models/tips_model.dart';
import 'package:bwa_cozy/providers/space_provider.dart';
import 'package:flutter/material.dart';
import 'package:bwa_cozy/theme.dart';
import 'package:bwa_cozy/widgets/city_card.dart';
import 'package:bwa_cozy/widgets/space_card.dart';
import 'package:bwa_cozy/widgets/tips_widget.dart';
import 'package:bwa_cozy/widgets/button_nav.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var spaceprovider = Provider.of<SpaceProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Text(
                  'Explore Now',
                  style: medium.copyWith(
                    fontSize: 24,
                  ),
                ),
              ),
              Text(
                'Mencari kosan yang cozy',
                style: light.copyWith(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              // NOTE: POPULAR CITIES
              Text(
                'Popular Cities',
                style: reguler.copyWith(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: 30,
                ),
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    CityCard(
                      City(
                        id: 1,
                        name: 'Jakarta',
                        image: 'assets/images/city1.png',
                        isPopular: false,
                      ),
                    ),
                    CityCard(
                      City(
                        id: 2,
                        name: 'Bandung',
                        image: 'assets/images/city2.png',
                        isPopular: true,
                      ),
                    ),
                    CityCard(
                      City(
                        id: 3,
                        name: 'Surabaya',
                        image: 'assets/images/city3.png',
                        isPopular: false,
                      ),
                    ),
                    CityCard(
                      City(
                        id: 4,
                        name: 'Palembang',
                        image: 'assets/images/city4.png',
                        isPopular: false,
                      ),
                    ),
                    CityCard(
                      City(
                        id: 5,
                        name: 'Aceh',
                        image: 'assets/images/city5.png',
                        isPopular: true,
                      ),
                    ),
                    CityCard(
                      City(
                        id: 0,
                        name: 'Bogor',
                        image: 'assets/images/city6.png',
                        isPopular: false,
                      ),
                    ),
                  ],
                ),
              ),
              // NOTE: RECOMENDDED SPACE
              Text(
                'Recommended Space',
                style: reguler.copyWith(fontSize: 16),
              ),
              SizedBox(
                height: 16,
              ),
              FutureBuilder(
                future: spaceprovider.getRecomenddedSpace(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Space> data = snapshot.data;
                    return Column(
                      children: data.map((e) => SpaceCard(space: e)).toList(),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),

              // NOTE: TIPS AND GUIDANCE
              Text(
                'Tips & Guidance',
                style: reguler.copyWith(fontSize: 16),
              ),
              SizedBox(
                height: 16,
              ),
              Column(
                children: [
                  TipsWidget(
                    tips: TipsnGuide(
                      id: 1,
                      title: 'City Guidelines',
                      image: 'assets/icons/city-guidelines.png',
                      time: '20 Apr',
                    ),
                  ),
                  TipsWidget(
                    tips: TipsnGuide(
                      id: 2,
                      title: 'Jakarta Fairship',
                      image: 'assets/icons/jkt-fair.png',
                      time: '11 Dec',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50.0 + 24.0,
              ),
            ],
          ),
        ),
      ),
      // NOTE: FLOATING BUTTON
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width - (2 * 24),
        height: 65,
        decoration: BoxDecoration(
          color: lightGrey,
          borderRadius: BorderRadius.circular(23),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ButtonNav(
              name: 'home',
              isActive: true,
            ),
            ButtonNav(
              name: 'mail',
              isActive: false,
            ),
            ButtonNav(
              name: 'card',
              isActive: false,
            ),
            ButtonNav(
              name: 'fav',
              isActive: false,
            ),
          ],
        ),
      ),
    );
  }
}
