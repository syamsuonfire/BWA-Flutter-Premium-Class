part of 'pages.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailPage(this.movie, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MovieDetail movieDetail;
    List<Credit> credits;

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          BlocProvider.of<PageBloc>(context).add(GoToMainPage());
          return;
        },
        child: Scaffold(
          body: FutureBuilder(
            future: MovieServices.getDetail(movie),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                movieDetail = snapshot.data;

                return CustomScrollView(
                  shrinkWrap: true,
                  slivers: [
                    SliverAppBar(
                      leading: IconButton(
                        onPressed: () {
                          BlocProvider.of<PageBloc>(context)
                              .add(GoToMainPage());
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        splashRadius: 24,
                      ),
                      expandedHeight: 270,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Image.network(
                          imageBaseURL +
                              "w1280" +
                              (movie.backdropPath ?? movie.posterPath),
                          fit: BoxFit.cover,
                        ),
                      ),
                      backgroundColor: mainColor,
                      title: Text("Movie Detail"),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                defaultMargin, 16, defaultMargin, 6),
                            child: Text(
                              movieDetail.title,
                              textAlign: TextAlign.center,
                              style: blackTextFont.copyWith(fontSize: 24),
                            ),
                          ),
                          Text(
                            movieDetail.genresAndLanguage,
                            style: greyTextFont.copyWith(
                                fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height: 6),
                          RatingStars(
                            voteAverage: movie.voteAverage,
                            color: accentColor3,
                            alignment: MainAxisAlignment.center,
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: defaultMargin, bottom: 12),
                              child: Text(
                                "Cast & Crew",
                                style: blackTextFont.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          FutureBuilder(
                            future: MovieServices.getCredits(movie.id),
                            builder: (_, snapshot) {
                              if (snapshot.hasData) {
                                credits = snapshot.data;

                                return SizedBox(
                                  height: 115,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: credits.length,
                                      itemBuilder: (_, index) => Container(
                                          margin: EdgeInsets.only(
                                              left: (index == 0)
                                                  ? defaultMargin
                                                  : 0,
                                              right:
                                                  (index == credits.length - 1)
                                                      ? defaultMargin
                                                      : 16),
                                          child: CreditCard(credits[index]))),
                                );
                              } else {
                                return SizedBox(
                                  height: 70,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 4,
                                    itemBuilder: (_, i) => Shimmer.fromColors(
                                      baseColor: Colors.blueGrey,
                                      highlightColor: Colors.white,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: (i == 0) ? defaultMargin : 0,
                                            right: (i == 4 - 1)
                                                ? defaultMargin
                                                : 16),
                                        width: 70,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                          // note: STORYLINE
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                defaultMargin, 24, defaultMargin, 8),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Storyline",
                                style: blackTextFont,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                defaultMargin, 0, defaultMargin, 30),
                            child: Text(
                              movie.overview,
                              style: greyTextFont.copyWith(
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          // note: BUTTON
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              primary: mainColor,
                            ),
                            child: Text(
                              "Continue to Book",
                              style: whiteTextFont.copyWith(fontSize: 16),
                            ),
                            onPressed: () {
                              BlocProvider.of<PageBloc>(context)
                                  .add(GoToSelectSchedulePage(movieDetail));
                            },
                          ),
                          SizedBox(height: defaultMargin),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(mainColor),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
