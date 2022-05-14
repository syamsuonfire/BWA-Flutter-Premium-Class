part of 'services.dart';

class UserServices {
  static CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  static Future<void> updateUser(AppUser user) async {
    _userCollection.doc(user.id).set({
      'email': user.email,
      'name': user.name,
      'balance': user.balance,
      'selectedGenres': user.selectedGenres,
      'selectedLanguage': user.selectedLanguage,
      'profilePicture': user.profilePicture ?? ""
    });
  }

  static Future<AppUser> getUser(String id) async {
    DocumentSnapshot snapshot = await _userCollection.doc(id).get();

    return AppUser(id, snapshot.get('email'),
        balance: snapshot.get('balance'),
        profilePicture: snapshot.get('profilePicture'),
        selectedGenres: new List<String>.from(snapshot.get('selectedGenres')),
        selectedLanguage: snapshot.get('selectedLanguage'),
        name: snapshot.get('name'));
  }
}
