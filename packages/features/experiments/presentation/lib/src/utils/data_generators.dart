import 'dart:math';

final r = Random();

String generateRandomString(int len) => String.fromCharCodes(List.generate(len, (index) => r.nextInt(25) + 97));
