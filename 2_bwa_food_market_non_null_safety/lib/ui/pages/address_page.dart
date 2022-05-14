part of 'pages.dart';

class AddressPage extends StatefulWidget {
  final User user;
  final String password;
  final File pictureFile;

  AddressPage(this.user, this.password, this.pictureFile);
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController houseNumController = TextEditingController();
  bool isLoading = false;
  List<String> cities;
  String selectedCity;

  @override
    void initState() {
      super.initState();
      
      cities = ["Banda Aceh", "Medan", "Jakarta"];
      selectedCity = cities[0];
    } 


  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      title: "Address ",
      subtitle: "Make sure it's valid",
      onBackButtonPressed: () {
        Get.back();
      },
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(defaultMargin, 26, defaultMargin, 6),
            width: double.infinity,
            child: Text("Phone No.", style: blackFontStyle2),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black)
            ),
            child: TextField(
              controller: phoneController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: greyFontStyle,
                hintText: "Type your phone number"
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(defaultMargin, 16, defaultMargin, 6),
            width: double.infinity,
            child: Text("Address", style: blackFontStyle2),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black)
            ),
            child: TextField(
              controller: addressController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: greyFontStyle,
                hintText: "Type your address"
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(defaultMargin, 16, defaultMargin, 6),
            width: double.infinity,
            child: Text("House No.", style: blackFontStyle2),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black)
            ),
            child: TextField(
              controller: houseNumController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: greyFontStyle,
                hintText: "Type your house number"
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(defaultMargin, 16, defaultMargin, 6),
            width: double.infinity,
            child: Text("City", style: blackFontStyle2),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black)
            ),
            child: DropdownButton(
              value: selectedCity,
              isExpanded: true,
              underline: SizedBox(),
              items: cities.map((e) => 
                DropdownMenuItem(
                  value: e,
                  child: Text(e, style: blackFontStyle3)
              )).toList(),
              onChanged:(item) {
                setState(() {
                  selectedCity = item;                  
                });
              }
            )
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 24),
            height: 45,
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: (isLoading == true) 
              ? Center(child: loadingIndicator) : RaisedButton(
              elevation: 0,
              onPressed: () async {
                User user = widget.user.copyWith(
                  phoneNumber: phoneController.text,
                  address: addressController.text,
                  houseNumber: houseNumController.text,
                  city: selectedCity
                );

                setState((){
                  isLoading = true;
                });

                await context.read<UserCubit>().singUp(user, widget.password, pictureFile: widget.pictureFile);

                UserState state = context.read<UserCubit>().state;

                if (state is UserLoaded) {
                  context.read<FoodCubit>().getFoods();
                  context.read<TransactionCubit>().getTransaction();
                  Get.to(MainPage());
                } else {
                  Get.snackbar(
                    "",
                    "",
                    backgroundColor: "D9435E".toColor(),
                    icon: Icon(MdiIcons.closeCircleOutline,
                        color: Colors.white),
                    titleText: Text("Sign Up Faild",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600)),
                    messageText: Text((state as UserLoadingFailed).message, style: GoogleFonts.poppins(color: Colors.white)),
                  );
                  setState(() {
                    isLoading = false;
                  });
                }
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              color: mainColor,
              child: Text("Sign Up Now", style: blackFontStyle3.copyWith(fontWeight: FontWeight.w500),),
            ),
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}