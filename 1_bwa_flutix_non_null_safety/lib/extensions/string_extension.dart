part of 'extensions.dart';

extension StringExtension on String {
  int cleanToInt() =>
      int.tryParse(this.replaceAll(new RegExp(r'[^0-9]'), '')) ?? 0;
}
