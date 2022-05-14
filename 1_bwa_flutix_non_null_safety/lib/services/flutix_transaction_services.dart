part of 'services.dart';

class FlutixTransactionServices {
  static CollectionReference _transactionCollection =
      FirebaseFirestore.instance.collection('transactions');

  static Future<void> saveTransaction(
      FlutixTransaction flutixTransaction) async {
    await _transactionCollection.doc().set({
      'userID': flutixTransaction.userID,
      'title': flutixTransaction.title,
      'subtitle': flutixTransaction.subtitle,
      'time': flutixTransaction.time.millisecondsSinceEpoch,
      'amount': flutixTransaction.amount,
      'picture': flutixTransaction.picture,
    });
  }

  static Future<List<FlutixTransaction>> getTransactions(String userID) async {
    QuerySnapshot snapshot =
        await _transactionCollection.where('userID', isEqualTo: userID).get();

    return snapshot.docs
        .map((e) => FlutixTransaction(
              userID: e.get('userID'),
              title: e.get('title'),
              subtitle: e.get('subtitle'),
              time: DateTime.fromMillisecondsSinceEpoch(e.get('time')),
              amount: e.get('amount'),
              picture: e.get('picture'),
            ))
        .toList();
  }
}
