import 'dart:math';
import "dart:developer" as dev;

class Cipher {
  static const int _asciiLen = 127;
  static String encode(String text, int? seed) {
    dev.log("encoding with seed: $seed");
    if (seed == null) return text;
    final Random rng = Random(seed);
    final List<int> ascii = text.codeUnits;
    final List<int> shifted = ascii.map(
      (e) {
        final int shiftedAscii = _addToCode(e, rng.nextInt(_asciiLen));
        return shiftedAscii;
      },
    ).toList();
    return String.fromCharCodes(shifted);
  }

  static String decode(String hash, int? seed) {
    dev.log("decoding with seed: $seed");
    if (seed == null) return hash;
    final Random rng = Random(seed);
    final List<int> ascii = hash.codeUnits;
    final List<int> shifted = ascii.map(
      (e) {
        final int shiftedAscii = _substractFromCode(e, rng.nextInt(_asciiLen));
        return shiftedAscii;
      },
    ).toList();
    return String.fromCharCodes(shifted);
  }

  static int _addToCode(int code, int value) {
    if (code + value > _asciiLen) {
      return code + value - _asciiLen - 1;
    }
    return code + value;
  }

  static int _substractFromCode(int code, int value) {
    if (value > code) {
      return _asciiLen + code - value + 1;
    }
    return code - value;
  }
}
