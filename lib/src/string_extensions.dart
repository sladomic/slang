import 'package:fast_i18n/src/model/build_config.dart';

extension StringExtensions on String {
  /// capitalizes a given string
  /// 'hello' => 'Hello'
  /// 'Hello' => 'Hello'
  /// '' => ''
  String capitalize() {
    if (this.isEmpty) return '';
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }

  /// transforms the string to the specified case
  /// if case is null, then no transformation will be applied
  String toCase(CaseStyle? keyCase) {
    switch (keyCase) {
      case CaseStyle.camel:
        return _getWords(this)
            .mapIndexed((index, word) =>
                index == 0 ? word.toLowerCase() : word.capitalize())
            .join('');
      case CaseStyle.pascal:
        return _getWords(this).map((word) => word.capitalize()).join('');
      case CaseStyle.snake:
        return _getWords(this).map((word) => word.toLowerCase()).join('_');
      case null:
        return this;
      default:
        print('Unknown key case: $keyCase');
        return this;
    }
  }
}

extension<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(int i, E e) f) {
    var i = 0;
    return map((e) => f(i++, e));
  }
}

final RegExp _upperAlphaRegex = RegExp(r'[A-Z]');
final Set<String> _symbolSet = {' ', '.', '_', '-', '/', '\\'};

/// get word list from string input
/// assume that words are separated by special characters or by camel case
List<String> _getWords(String input) {
  final StringBuffer buffer = StringBuffer();
  final List<String> words = [];
  final bool isAllCaps = input.toUpperCase() == input;

  for (int i = 0; i < input.length; i++) {
    final String currChar = input[i];
    final String? nextChar = i + 1 == input.length ? null : input[i + 1];

    if (_symbolSet.contains(currChar)) {
      continue;
    }

    buffer.write(currChar);

    final bool isEndOfWord = nextChar == null ||
        (!isAllCaps && _upperAlphaRegex.hasMatch(nextChar)) ||
        _symbolSet.contains(nextChar);

    if (isEndOfWord) {
      words.add(buffer.toString());
      buffer.clear();
    }
  }

  return words;
}
