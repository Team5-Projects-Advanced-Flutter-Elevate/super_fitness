abstract class ObfuscatedPassword {
  static String getObfuscatedPassword() {
    final List<int> codes = [
      94,
      107,
      48,
      57,
      65,
      99,
      115,
      105,
      59,
      64,
      50,
      112,
    ];
    final scrambled = codes.reversed.toList();
    final unscrambled = scrambled.reversed.toList();
    return String.fromCharCodes(unscrambled);
  }
}
