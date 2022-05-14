part of 'pages.dart';

class EditProfilePage extends StatefulWidget {
  final AppUser user;

  const EditProfilePage(this.user, {Key key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController;
  String profilePath;
  bool isDataEdited = false;
  File profileImageFile;
  bool isUpdating = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    profilePath = widget.user.profilePicture;
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ThemeBloc>(context)
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor2)));

    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<PageBloc>(context).add(GoToProfilePage());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: ListView(children: [
              Column(children: [
                SizedBox(height: 20),
                Text(
                  "Edit Your\nProfile",
                  textAlign: TextAlign.center,
                  style: blackTextFont.copyWith(fontSize: 20),
                ),
                Container(
                  margin: EdgeInsets.only(top: 22, bottom: 10),
                  width: 90,
                  height: 104,
                  child: Stack(children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: (profileImageFile != null)
                                ? FileImage(profileImageFile)
                                : (profilePath != "")
                                    ? NetworkImage(profilePath)
                                    : AssetImage("assets/user_pic.png"),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () async {
                          if (profilePath == "") {
                            profileImageFile = await getImage();

                            if (profileImageFile != null) {
                              profilePath = basename(profileImageFile.path);
                            }
                          } else {
                            profileImageFile = null;
                            profilePath = "";
                          }

                          setState(() {
                            isDataEdited = (nameController.text.trim() !=
                                        widget.user.name ||
                                    profilePath != widget.user.profilePicture)
                                ? true
                                : false;
                          });
                        },
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage((profilePath == "")
                                  ? "assets/btn_add_photo.png"
                                  : "assets/btn_del_photo.png"),
                            ),
                          ),
                        ),
                      ),
                    )
                  ]),
                ),
                AbsorbPointer(
                  child: TextField(
                    controller: TextEditingController(text: widget.user.id),
                    style: whiteNumberFont.copyWith(color: accentColor3),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "User ID",
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                AbsorbPointer(
                  child: TextField(
                    controller: TextEditingController(text: widget.user.email),
                    style: greyTextFont,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "Email Address",
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: nameController,
                  onChanged: (text) {
                    setState(() {
                      isDataEdited = (text.trim() != widget.user.name ||
                              profilePath != widget.user.profilePicture)
                          ? true
                          : false;
                    });
                  },
                  style: blackTextFont,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "Full Name",
                    hintText: "Full Name",
                  ),
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: 250,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      primary: Colors.red[400],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          MdiIcons.alertCircle,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Change Password",
                          style: whiteTextFont.copyWith(
                            fontSize: 16,
                            color:
                                (isUpdating) ? Color(0xFFBEBEBE) : Colors.white,
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          MdiIcons.alertCircle,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                    onPressed: (isUpdating)
                        ? null
                        : () async {
                            await AuthServices.resetPassword(widget.user.email);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "The link to change your password has been sent to your email."),
                                backgroundColor: Color(0xFFFF5C83),
                              ),
                            );
                          },
                  ),
                ),
                SizedBox(height: 16),
                (isUpdating)
                    ? SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          color: Color(0xFF3E9D9D),
                        ),
                      )
                    : SizedBox(
                        width: 250,
                        height: 45,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF3E9D9D),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              "Update My Profile",
                              style: whiteTextFont.copyWith(
                                  fontSize: 16,
                                  color: (isDataEdited)
                                      ? Colors.white
                                      : Color(0xFFBEBEBE)),
                            ),
                            onPressed: (isDataEdited)
                                ? () async {
                                    setState(() {
                                      isUpdating = true;
                                    });

                                    if (profileImageFile != null) {
                                      profilePath = await uploadImage(
                                          profileImageFile, widget.user.id);
                                    }

                                    BlocProvider.of<UserBloc>(context).add(
                                        UpdateData(
                                            name: nameController.text,
                                            profileImage: profilePath));

                                    BlocProvider.of<PageBloc>(context)
                                        .add(GoToProfilePage());
                                  }
                                : null),
                      ),
              ]),
            ]),
          ),
          SafeArea(
            child: Container(
              margin: EdgeInsets.only(top: 20, left: defaultMargin),
              child: GestureDetector(
                onTap: () {
                  BlocProvider.of<PageBloc>(context).add(GoToProfilePage());
                },
                child: Icon(Icons.arrow_back, color: Colors.black),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
