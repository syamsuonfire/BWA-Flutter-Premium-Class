part of 'pages.dart';

class FoodPage extends StatefulWidget {
  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double listItemWidth =
        MediaQuery.of(context).size.width - 2 * defaultMargin;
    return ListView(
      children: [
        Column(
          children: [
            //// HEADER
            Container(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              color: Colors.white,
              height: 100,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Food Market",
                        style: blackFontStyle1,
                      ),
                      Text(
                        "Let's get some food",
                        style:
                            greyFontStyle.copyWith(fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            image: NetworkImage(
                                (context.watch<UserCubit>().state as UserLoaded)
                                    .user
                                    .picturePath),
                            fit: BoxFit.cover)),
                  )
                ],
              ),
            ),
            //// LIST OF FOOD
            Container(
                height: 258,
                width: double.infinity,
                child: BlocBuilder<FoodCubit, FoodState>(
                  builder: (_, state) => (state is FoodLoaded) ? ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Row(
                            children: state.foods
                                .map((e) => Padding(
                                      padding: EdgeInsets.only(
                                          left: (e == state.foods.first)
                                              ? defaultMargin
                                              : 0,
                                          right: defaultMargin),
                                      child: GestureDetector(
                                          onTap: () {
                                            Get.to(
                                              FoodDetailsPage(
                                                  transaction: Transaction(
                                                    food: e,
                                                    user: (context
                                                            .read<UserCubit>()
                                                            .state as UserLoaded)
                                                        .user,
                                                  ),
                                                  onBackButtonPressed: () {
                                                    Get.back();
                                                  }),
                                            );
                                          },
                                          child: FoodCard(e)),
                                  )).toList()
                        ),
                      ],
                    ) : Center(child: loadingIndicator)
                )),
            //// LIST OF FOOD (TABS)
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  CustomTabbar(
                    selectedIndex: selectedIndex,
                    titles: ['New Taste', 'Pupular', 'Recomended'],
                    onTap: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  BlocBuilder<FoodCubit, FoodState>(
                    builder: (_, state) {
                      if(state is FoodLoaded){
                      List<Food> foods = state.foods.where((element) => element.types.contains(
                        (selectedIndex == 0)
                          ? FoodType.new_food
                          : (selectedIndex == 1)
                              ? FoodType.popular
                              : FoodType.recomended
                      )).toList();
                      return Column(
                        children: foods
                            .map((e) => Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      defaultMargin, 0, defaultMargin, 16),
                                  child: GestureDetector(
																		onTap: () => Get.to(
																			FoodDetailsPage(
																				transaction: Transaction(
																					food: e,
																					user: (context.read<UserCubit>().state as UserLoaded).user,
																				),
																				onBackButtonPressed: () => Get.back(),
																			)
																		),
																		child: FoodListItem(
                                        food: e, itemWidth: listItemWidth),
                                  ),
                                ))
                            .toList(),
                      );
                      } else {
                        return Center(child: loadingIndicator);
                      }
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: 80,
            ),
          ],
        )
      ],
    );
  }
}
