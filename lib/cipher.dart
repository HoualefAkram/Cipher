import 'dart:math';
import 'dart:developer' as dev;

class Cipher {
  static const int _asciiLen = 127;
  static const int _maxShift = 10000;
  // static final List<int> _removedAscii = List.generate(32, (index) => index)
  //   ..add(127);
  // static const int _spaceAscii = 32;
  static String encode(String text, int? seed) {
    if (seed == null) return text;
    final Random rng = Random(seed);
    final List<int> ascii = text.codeUnits;
    final List<int> shifted = ascii
        .map(
          (e) => _addToCode(e, rng.nextInt(_maxShift)),
        )
        .toList();
    dev.log(shifted.toString());
    return String.fromCharCodes(shifted);
  }

  static String decode(String hash, int? seed) {
    if (seed == null) return hash;
    final Random rng = Random(seed);
    final List<int> ascii = hash.codeUnits;
    final List<int> shifted = ascii.map(
      (e) {
        final int shiftedAscii = _substractFromCode(e, rng.nextInt(_maxShift));
        return shiftedAscii;
      },
    ).toList();
    return String.fromCharCodes(shifted);
  }

  static int _addToCode(int code, int value) {
    int output = (code + value) % _asciiLen;
    // return _removedAscii.contains(output) ? _spaceAscii : output;
    return output;
  }

  static int _substractFromCode(int code, int value) {
    final int sub = code - value;
    final output = (sub % _asciiLen + _asciiLen) % _asciiLen;
    // return _removedAscii.contains(output) ? _spaceAscii : output;
    return output;
  }
}
