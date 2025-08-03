part of app_foundations;

/// => AI TESTED
abstract class Numeric {
  // -----------------------------------------------------------------------------

  /// FORMATTERS

  // --------------------
  /// AI TESTED
  static String formatNumToCounterCaliber({
    required int? x,
    String thousand = 'thousand',
    String million = 'million',
  }) {
    String _stringOfCalibratedNumber = '0';

    if (x != null) {
      /// FROM 0 TO 999
      if (x >= 0 && x < 1000) {
        _stringOfCalibratedNumber = x.toString();
      }

      /// FROM 1000 TO 99995
      else if (x >= 1000 && x < 99995) {
        _stringOfCalibratedNumber =
        '${(x / 1000).toStringAsFixed(1).replaceAll(RegExp('0.0'), '0').replaceAll(r'.0', '')}'
            ' $thousand';
      }

      /// FROM 99995 TO 999445
      else if (x >= 99995 && x < 999445) {
        _stringOfCalibratedNumber = '${int.parse((x / 1000).toStringAsFixed(0))}'
            ' $thousand';
      }

      /// FROM 999445 TO INFINITY
      else if (x >= 999445) {
        _stringOfCalibratedNumber =
        '${(x / 1000000).toStringAsFixed(1).replaceAll(RegExp('0.0'), '0').replaceAll(r'.0', '')}'
            ' $million';
      } else {
        _stringOfCalibratedNumber = x.toStringAsFixed(0);
      }
    }

    return _stringOfCalibratedNumber;
  }
  // --------------------
  /// AI TESTED
  static String? formatIntWithinDigits({
    required int? num,
    required int? digits,
  }) {

    /// this should put the number within number of digits
    /// for digits = 4,, any number should be written like this 0000
    /// 0001 -> 0010 -> 0100 -> 1000 -> 9999
    /// when num = 10000 => should return 'increase digits to view number'

    String? _output;

    if (num != null && digits != null) {

      final int _maxPlusOne = calculateIntegerPower(num: 10, power: digits);
      final int _maxPossibleNum = _maxPlusOne - 1;

      if (num > _maxPossibleNum) {
        _output = 'XXXX';
      }

      else {

        String _numAsText = num.toString();

        for (int i = 1; i <= digits; i++) {

          if (_numAsText.length < digits) {
            _numAsText = '0$_numAsText';
          }

          else {
            break;
          }

        }

        _output = _numAsText;
      }

    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static String? formatDoubleWithinDigits({
    required double? value,
    required int? digits,
    bool addPlus = true,
  }) {
    String? _output;

    if (value != null && digits != null) {

      // final double _maxPossibleValue =
      //         calculateDoublePower(num: 10, power: digits)
      //         -
      //         1 / math.pow(10, digits);

      _output = value.toStringAsFixed(digits);

      if (addPlus == true && value > 0){
        _output = '+$_output';
      }
      else if (addPlus == true && value < 0){
        _output = _output;
      }
      else if (addPlus == true && value == 0){
        _output = '±$_output';
      }

    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static int concludeNumberOfDigits(int? length){
    int _length = 0;

    if (length != null && length != 0){
      _length = modulus(length.toDouble())?.toInt() ?? 0;
      _length = _length.toString().length;
    }

    return _length;
  }
  // --------------------
  /// AI TESTED
  static String? formatIndexDigits({
    required int? index,
    required int? listLength,
  }){

    return formatIntWithinDigits(
      digits: concludeNumberOfDigits(listLength),
      num: index,
    );

  }
  // -----------------------------------------------------------------------------

  /// TRANSFORMERS

  // --------------------
  /// AI TESTED
  static String formatToRomanA(int number) {

    // Define mappings for Roman numerals and their corresponding values.
    final Map<String, int> romanNumerals = {
      'M': 1000,
      'CM': 900,
      'D': 500,
      'CD': 400,
      'C': 100,
      'XC': 90,
      'L': 50,
      'XL': 40,
      'X': 10,
      'IX': 9,
      'V': 5,
      'IV': 4,
      'I': 1,
    };

    // Check if the input number is within the valid range (1 to 3999).
    if (number < 1 || number > 3999) {
      return '';
    }

    // Initialize an empty string to store the Roman numeral representation.
    String result = '';

    // Use a local variable to perform calculations.
    int remainingValue = number;

    // Iterate through the Roman numerals mapping and build the Roman numeral string.
    romanNumerals.forEach((numeral, value) {
      while (remainingValue >= value) {
        // Append the Roman numeral to the result.
        result += numeral;
        // Subtract the value of the Roman numeral from the remainingValue.
        remainingValue -= value;
      }
    });

    return result;
}
  // --------------------
  /// AI TESTED
  static String formatToRomanB(int input) {
    const List<int> arabianRomanNumbers = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];

    const List<String> romanNumbers = [
      'M',
      'CM',
      'D',
      'CD',
      'C',
      'XC',
      'L',
      'XL',
      'X',
      'IX',
      'V',
      'IV',
      'I'
    ];

    var num = input;

    if (num < 0) {
      return '';
    } else if (num == 0) {
      return '';
    }

    final builder = StringBuffer();
    for (var a = 0; a < arabianRomanNumbers.length; a++) {
      final times = (num / arabianRomanNumbers[a]).truncate(); // equals 1 only when arabianRomanNumbers[a] = num
      // executes n times where n is the number of times you have to add
      // the current roman number value to reach current num.
      builder.write(romanNumbers[a] * times);
      num -= times * arabianRomanNumbers[a]; // subtract previous roman number value from num
    }

    return builder.toString();
  }
  // -----------------------------------------------------------------------------

  /// TRANSFORMERS

  // --------------------
  /// AI TESTED
  static int? transformStringToInt(String? string) {
    int? _value;

    if (string != null) {
      final double? _doubleValue = double.tryParse(string);
      _value = _doubleValue?.toInt();
    }

    return _value;
  }
  // --------------------
  /// AI TESTED
  static double? transformStringToDouble(String? string) {
    double? _value;

    if (string != null && string.trim() != '') {
      _value = double.tryParse(string);
    }

    return _value;
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TASK : TEST ME
  static List<int> getIntsFromDynamics({
    required List<dynamic>? dynamics,
    bool intifyDoubles = false,
  }){
    final List<int> _ints = <int>[];

    if (dynamics != null){
      // _ints.addAll(_ints);

      for (int i = 0; i < dynamics.length; i++){

        final dynamic _object = dynamics[i];

        if (_object is int){
          _ints.add(dynamics[0]);
        }

        if (_object is double && intifyDoubles == true){
          final double _d = dynamics[0];
          _ints.add(_d.toInt());
        }

      }

    }



    return _ints;
  }
  // -----------------------------------------------------------------------------

  /// CALCULATORS

  // --------------------
  /// AI TESTED
  static int? calculateDiscountPercentage({
    required double? oldPrice,
    required double? currentPrice,
  }) {
    if (oldPrice == null || currentPrice == null){
      return null;
    }
    else if (oldPrice == 0){
      return 0;
    }
    else {
      final double _percent = ((oldPrice - currentPrice) / oldPrice) * 100;
      return _percent.round();
    }
  }
  // --------------------
  /// AI TESTED
  static int calculateIntegerPower({
    required int? num,
    required int? power,
  }) {

      /// NOTE :  num = 10; power = 2; => 10^2 = 100,, cheers
      int _output = 1;

      if (num != null && power != null) {
        for (int i = 0; i < power; i++) {
          _output *= num;
        }
      }

      return _output;

  }
  // --------------------
  /// AI TESTED
  static double calculateDoublePower({
    required double? num,
    required int? power,
  }) {

    /// NOTE :  num = 10; power = 2; => 10^2 = 100,, cheers
    double _output = 1;

    if (num != null && power != null){
      for (int i = 0; i < power; i++) {
        _output *= num;
      }
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// BINARY SEARCH

  // --------------------
  /// AI TESTED
  static int? binarySearch({
    required List<int?>? list,
    required int? searchedValue,
  }) {

    if (list == null || list.isEmpty || searchedValue == null) {
      return null;
    }

    else {

      int _min = 0;
      int _max = list.length - 1;
      int? _output;

      while (_min <= _max) {

        final int _mid = ((_min + _max) / 2).floor();

        if (searchedValue == list[_mid]) {
          _output = _mid;
          break; // Exit the loop when the searched value is found
        }

        else if (searchedValue < list[_mid]!) {
          _max = _mid - 1;
        }

        else {
          _min = _mid + 1;
        }

      }

      return _output;
    }

  }
  // -----------------------------------------------------------------------------

  /// MODULUS

  // --------------------
  /// AI TESTED
  static double? modulus(double? num){
    double? _val;

    /// NOTE : GETS THE ABSOLUTE VALUE OF A DOUBLE

    if (num != null){
      _val = math.sqrt(calculateDoublePower(num: num, power: 2));
    }

    return _val;
  }
  // --------------------
  /// AI TESTED
  static int? modulusInteger(int? num){
    int? _val;

    if (num != null){

      if (num < 0){
        _val = num * -1;
      }
      else {
        _val = num;
      }


    }

    return _val;
  }
  // -----------------------------------------------------------------------------

  /// DIVISION

  // --------------------
  ///
  static double divide({
    /// بسط
    required num? dividend,
    /// مقام
    required num? divisor,
  }){
    double _output = 0;

    if (dividend != null && divisor != null && divisor != 0){
      _output = dividend / divisor;
    }

    return _output;
  }
  // --------------------
  ///
  static double? getDivisionRemainder({
    required double? dividend,
    required double? divisor
  }) {

    if (dividend == null || divisor == null){
      return null;
    }
    else {
      final double remainder = dividend % divisor; // Modulo operator to get the remainder
      return remainder;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int? getDivisionQuotient({
    required double? dividend,
    required double? divisor
  }) {
    if (dividend == null || divisor == null){
      return null;
    }
    else {
      final int quotient = dividend ~/ divisor; // Integer division to get the quotient
      return quotient;
    }
  }
  // -----------------------------------------------------------------------------

  /// RANGER

  // --------------------
  /// AI TESTED
  static int? getClosestInt({
    required List<int> ints,
    required double value,
  }) {

    if (ints.isEmpty){
      return null;
    }
    else {
      int _closest = ints.first;
      final double _value = value;
      double difference = modulus(_value - _closest)!;

      for (final int in ints){

        final double _diff = modulus(_value - int)!;

        if (_diff < difference){
          difference = _diff;
          _closest = int;
        }

      }

      return _closest;
    }


}
  // -----------------------------------------------------------------------------

  /// COMPARISON OPERATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool isGreaterThan({
    required num? number,
    required num? isGreaterThan,
  }){
    bool _output = false;

    if (number != null && isGreaterThan != null){
      _output = number > isGreaterThan;
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool isGreaterThanOrEqual({
    required num? number,
    required num? isGreaterThan,
  }){
    bool _output = false;

    if (number != null && isGreaterThan != null){
      _output = number >= isGreaterThan;
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool isLesserThan({
    required num? number,
    required num? isLesserThan,
  }){
    bool _output = false;

    if (number != null && isLesserThan != null){
      _output = number < isLesserThan;
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool isLesserThanOrEqual({
    required num? number,
    required num? isLesserThan,
  }){
    bool _output = false;

    if (number != null && isLesserThan != null){
      _output = number <= isLesserThan;
    }

    return _output;
  }
  // --------------------
  ///
  static bool isBetween(double number, double valueA, double valueB){

    if (number == valueA && number == valueB){
      return false;
    }
    else if (valueA == valueB){
      return false;
    }
    else {

      final double _bigger = valueA > valueB ? valueA : valueB;
      final double _smaller = valueA < valueB ? valueA : valueB;

      if (number < _bigger && number > _smaller){
        return true;
      }
      else {
        return false;
      }

    }

  }
  // -----------------------------------------------------------------------------
}

/// => AI TESTED
abstract class Indexer {
  // -----------------------------------------------------------------------------

  /// CREATE RANDOM

  // --------------------
  /// AI TESTED
  static int createRandomIndex({
    int listLength = 1001, /// FOR 1000 ITEMS => ONLY VALUES FROM ( 0 -> 999 ) MAY RESULT
  }) {
    return math.Random().nextInt(listLength);
  }
  // --------------------
  /// AI TESTED
  static List<int> createRandomIndexes({
    required int numberOfIndexes,
    required int maxIndex,
  }) {
    final List<int> _indexes = <int>[];

    for (int i = 0; i < numberOfIndexes; i++) {

      final int _newIndex = createUniqueIndex(
          existingIndexes: _indexes,
          maxIndex: maxIndex
      );

      _indexes.add(_newIndex);
    }
    return _indexes;
  }
  // -----------------------------------------------------------------------------

  /// CREATE UNIQUE

  // --------------------
  /// AI TESTED
  static int createUniqueIndex({
    required List<int>? existingIndexes,
    int maxIndex = 999999,
  }) {
    /// from 0 up to 999'999 included if max index is not defined
    int _randomNumber = math.Random().nextInt(maxIndex + 1);

    // blog('random number is : $_randomNumber');

    if (existingIndexes != null && existingIndexes.contains(_randomNumber) == true) {
      _randomNumber = createUniqueIndex(
        existingIndexes: existingIndexes,
        maxIndex: maxIndex,
      );
    }

    return _randomNumber;
  }
  // -----------------------------------------------------------------------------

  /// INDEX MANIPULATION

  // --------------------
  /// AI TESTED
  static int? reverseIndex({
    required int? listLength,
    required int? index,
  }) {

    if (listLength != null && index != null) {

      if (index + 1 <= listLength) {
        List<int> _indexes = <int>[];

        for (int i = 0; i < listLength; i++) {
          _indexes.add(i);
        }
        _indexes = _indexes.reversed.toList();

        final int _reversedIndex = _indexes.indexOf(index);

        return _reversedIndex;
      }

      else {
        return null;
      }

    }

    else {
      return null;
    }

  }
  // --------------------
  /// AI TESTED
  static int? getNextIndex({
    required int? listLength,
    required int? currentIndex,
    required bool loop,
  }){
    int? _output;

    if (listLength == null || currentIndex == null){
      _output = null;
    }
    else {

      final bool _isAtLast = currentIndex + 1 == listLength;

      /// AT LAST
      if (_isAtLast == true){

        if (loop == true){
          _output = 0;
        }
        else {
          _output = currentIndex;
        }

      }

      /// IN THE MIDDLE
      else {
        _output = currentIndex + 1;
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
  void x(){}
}
