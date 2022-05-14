part of 'pages.dart';

class PreferencePage extends StatefulWidget {
  final RegistrationData registrationData;
  final List<String> genres = [
    "Horror",
    "Music",
    "Action",
    "Drama",
    "War",
    "Crime"
  ];
  final List<String> languages = ["Bahasa", "English", "Japanese", "Korean"];

  PreferencePage(this.registrationData, {Key key}) : super(key: key);

  @override
  _PreferencePageState createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {
  List<String> selectedGenres = [];
  String selectedLanguage = "English";

  @override
  void initState() {
    super.initState();

    if (widget.registrationData.selectedGenres.length > 0) {
      selectedGenres = widget.registrationData.selectedGenres;
    }
    if (widget.registrationData.selectedLanguage.isNotEmpty) {
      selectedLanguage = widget.registrationData.selectedLanguage;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<PageBloc>(context)
            .add(GoToRegistrationPage(widget.registrationData));
        return;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: defaultMargin,
                  vertical: defaultMargin,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 56,
                      child: GestureDetector(
                        child: Icon(Icons.arrow_back),
                        onTap: () {
                          BlocProvider.of<PageBloc>(context).add(
                              GoToRegistrationPage(widget.registrationData));
                        },
                      ),
                    ),
                    Text(
                      "Select Your Four\nFavorite Genres",
                      style: blackTextFont.copyWith(fontSize: 20),
                    ),
                    SizedBox(height: 16),
                    Wrap(
                      spacing: 24,
                      runSpacing: 24,
                      children: generateGenreWidgets(context),
                    ),
                    SizedBox(height: 24),
                    Text(
                      "Movie Language\nYou Prefer?",
                      style: blackTextFont.copyWith(fontSize: 20),
                    ),
                    SizedBox(height: 16),
                    Wrap(
                      spacing: 24,
                      runSpacing: 24,
                      children: generateLangWidgets(context),
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: FloatingActionButton(
                        child: Icon(Icons.arrow_forward),
                        backgroundColor: mainColor,
                        elevation: 0,
                        onPressed: () {
                          if (selectedGenres.length != 4) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Please select 4 genres"),
                                backgroundColor: Color(0xFFFF5C83),
                              ),
                            );
                          } else {
                            widget.registrationData.selectedGenres =
                                selectedGenres;
                            widget.registrationData.selectedLanguage =
                                selectedLanguage;

                            BlocProvider.of<PageBloc>(context).add(
                                GoToAccountConfirmationPage(
                                    widget.registrationData));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> generateGenreWidgets(BuildContext context) {
    double width =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 24) / 2;

    return widget.genres
        .map((genre) => SelectableBox(
              text: genre,
              width: width,
              isSelected: selectedGenres.contains(genre),
              onTap: () {
                onSelectGenre(genre);
              },
            ))
        .toList();
  }

  void onSelectGenre(String genre) {
    if (selectedGenres.contains(genre)) {
      setState(() {
        selectedGenres.remove(genre);
      });
    } else if (selectedGenres.length < 4) {
      setState(() {
        selectedGenres.add(genre);
      });
    }
  }

  List<Widget> generateLangWidgets(BuildContext context) {
    double width =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 24) / 2;

    return widget.languages
        .map((language) => SelectableBox(
              text: language,
              width: width,
              isSelected: selectedLanguage == language,
              onTap: () {
                setState(() {
                  selectedLanguage = language;
                });
              },
            ))
        .toList();
  }
}
