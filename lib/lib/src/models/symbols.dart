enum SymbolType { number, operator, function }

class SymbolModel {
  final String name;
  final SymbolType type;

  SymbolModel({required this.name, required this.type});

  @override
  String toString() {
    return 'SymbolModel(name: $name, type: $type)';
  }

  String textName() {
    switch (name) {
      case 'plus':
        return '+';
      case 'minus':
        return '-';
      case 'multiply':
        return 'x';
      case 'divide':
        return '/';
      case 'equal':
        return '=';
      default:
        return '';
    }
  }

  String assetName() => 'assets/svgs/$name.svg';
}

class Symbols {
  // Operators
  static SymbolModel plusSymbol = SymbolModel(
    name: 'plus',
    type: SymbolType.operator,
  );
  static SymbolModel minusSymbol = SymbolModel(
    name: 'minus',
    type: SymbolType.operator,
  );
  static SymbolModel multiplySymbol = SymbolModel(
    name: 'multiply',
    type: SymbolType.operator,
  );
  static SymbolModel divideSymbol = SymbolModel(
    name: 'divide',
    type: SymbolType.operator,
  );
  static SymbolModel equalSymbol = SymbolModel(
    name: 'equal',
    type: SymbolType.operator,
  );

  // Functions
  static SymbolModel percentageSymbol = SymbolModel(
    name: 'percentage',
    type: SymbolType.function,
  );
  static SymbolModel deleteSymbol = SymbolModel(
    name: 'delete',
    type: SymbolType.function,
  );
  static SymbolModel clearSymbol = SymbolModel(
    name: 'clear',
    type: SymbolType.function,
  );

  // Clear Symbol

  static String clearSymbolName(String expression) {
    if (expression.isEmpty) {
      return 'AC';
    } else {
      return 'C';
    }
  }

  static List<SymbolModel> firstRow = [
    clearSymbol,
    deleteSymbol,
    percentageSymbol,
    divideSymbol,
  ];

  static List<SymbolModel> secondRow = [
    SymbolModel(name: '7', type: SymbolType.number),
    SymbolModel(name: '8', type: SymbolType.number),
    SymbolModel(name: '9', type: SymbolType.number),
    multiplySymbol,
  ];

  static List<SymbolModel> thirdRow = [
    SymbolModel(name: '4', type: SymbolType.number),
    SymbolModel(name: '5', type: SymbolType.number),
    SymbolModel(name: '6', type: SymbolType.number),
    minusSymbol,
  ];

  static List<SymbolModel> fourthRow = [
    SymbolModel(name: '1', type: SymbolType.number),
    SymbolModel(name: '2', type: SymbolType.number),
    SymbolModel(name: '3', type: SymbolType.number),
    plusSymbol,
  ];

  static List<SymbolModel> fifthRow = [
    SymbolModel(name: '000', type: SymbolType.number),
    SymbolModel(name: '0', type: SymbolType.number),
    SymbolModel(name: '.', type: SymbolType.number),
    equalSymbol,
  ];
}
