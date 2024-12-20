extension VietnameseCurrencyFormatterExtensions on String {
  /// Sample: '-1000000.234' => '-1,000,000.234 đ'
  /// Sample: '1000000.234' => '1,000,000.234 đ'
  String vndFormat([String suffix = 'đ']) {
    final bool isNegative = startsWith('-');
    String extractText = this;
    if (isNegative) {
      extractText = substring(1);
    }
    final List<String> parts = extractText.split('.');
    final String integerPart = parts[0];
    final String fractionalPart = parts.length > 1 ? parts[1] : '';
    final String reversedInteger = integerPart.split('').reversed.join();
    final String withCommasReversed = reversedInteger.replaceAllMapped(
      RegExp('.{1,3}'),
      (match) => '${match[0]},',
    );
    final String withCommas = withCommasReversed
        .split('')
        .reversed
        .join()
        .replaceFirst(RegExp('^,'), '');
    final String result = fractionalPart.isNotEmpty
        ? (fractionalPart == '0' ? withCommas : '$withCommas.$fractionalPart')
        : withCommas;
    return '${isNegative ? '-' : ''}$result $suffix';
  }

  /// Sample: '-1000000.234' => '1,000,000.234 đ'
  /// Sample: '1000000.234' => '1,000,000.234 đ'
  String vndFormatAbs([String suffix = 'đ']) {
    final bool isNegative = startsWith('-');
    String extractText = this;
    if (isNegative) {
      extractText = substring(1);
    }
    final List<String> parts = extractText.split('.');
    final String integerPart = parts[0];
    final String fractionalPart = parts.length > 1 ? parts[1] : '';
    final String reversedInteger = integerPart.split('').reversed.join();
    final String withCommasReversed = reversedInteger.replaceAllMapped(
      RegExp('.{1,3}'),
      (match) => '${match[0]},',
    );
    final String withCommas = withCommasReversed
        .split('')
        .reversed
        .join()
        .replaceFirst(RegExp('^,'), '');
    final String result = fractionalPart.isNotEmpty
        ? (fractionalPart == '0' ? withCommas : '$withCommas.$fractionalPart')
        : withCommas;
    return '$result $suffix';
  }

  /// Sample: '-1000000.234' => '-1,000,000.234 đ'
  /// Sample: '1000000.234' => '+1,000,000.234 đ'
  String vndFormatWithSign([String suffix = 'đ']) {
    final bool isNegative = startsWith('-');
    String extractText = this;
    if (isNegative) {
      extractText = substring(1);
    }

    return '${isNegative ? '-' : '+'}${extractText.vndFormatAbs(suffix)}';
  }
}

extension SensitiveInformationFilterExtensions on String {
  String sensitiveFilterPhoneNumber() {
    return this;
  }
}
