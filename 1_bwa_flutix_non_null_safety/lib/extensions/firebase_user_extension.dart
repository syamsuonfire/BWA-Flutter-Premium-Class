part of 'extensions.dart';

extension FirebaseUserExtension on User {
  AppUser convertToUser(
          {String name = "Anonymous",
          List<String> selectedGenres = const [],
          String selectedLanguage = "English",
          int balance = 50000}) =>
      AppUser(this.uid, this.email,
          name: name,
          balance: balance,
          selectedGenres: selectedGenres,
          selectedLanguage: selectedLanguage);

  Future<AppUser> fromFirestore() async => await UserServices.getUser(this.uid);
}
