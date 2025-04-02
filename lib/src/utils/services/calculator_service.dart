class CalculateHelper {
  // Helper method to format numbers and handle floating point precision
  String formatNumber(num number) {
    // Convert to string with 10 decimal places then remove trailing zeros
    return number.toStringAsFixed(10).replaceAll(RegExp(r'\.?0+$'), '');
  }

  String removeSpaces(String expression) => expression.replaceAll(' ', '');

  List<String> splitExpression(String expression) {
    expression = removeSpaces(expression);

    if (expression.isEmpty) {
      return [];
    } else if (!isContainsOperator(expression)) {
      return [expression];
    }
    final symbols =
        RegExp(
          r'(\d+\.?\d*)|([+\-x/])',
        ).allMatches(expression).map((match) => match.group(0)!).toList();
    return symbols;
  }

  bool isContainsMultiplicationOrDivision(String expression) {
    return expression.contains('x') || expression.contains('/');
  }

  bool isContainsAdditionOrSubtraction(String expression) {
    return expression.contains('+') || expression.contains('-');
  }

  bool isContainsOperator(String expression) =>
      isContainsMultiplicationOrDivision(expression) ||
      isContainsAdditionOrSubtraction(expression);

  String _add(String a, String b) {
    num result = num.parse(a) + num.parse(b);
    return formatNumber(result);
  }

  String _subtract(String a, String b) {
    num result = num.parse(a) - num.parse(b);
    return formatNumber(result);
  }

  String _multiply(String a, String b) {
    num result = num.parse(a) * num.parse(b);
    return formatNumber(result);
  }

  String _divide(String a, String b) {
    if (b == '0') return 'Error: Division by zero';
    num result = num.parse(a) / num.parse(b);
    return formatNumber(result);
  }
}

class Calculate {
  final helper = CalculateHelper();

  String _calculateAdditionAndSubtraction(List<String> symbols) {
    try {
      while (symbols.contains('-') || symbols.contains('+')) {
        final index = symbols.indexWhere(
          (symbol) => symbol == '-' || symbol == '+',
        );

        if (index <= 0 || index >= symbols.length - 1) break;

        final operator = symbols[index];
        final leftOperand = symbols[index - 1];
        final rightOperand = symbols[index + 1];

        String result;
        if (operator == '+') {
          result = helper._add(leftOperand, rightOperand);
        } else {
          result = helper._subtract(leftOperand, rightOperand);
        }

        symbols.replaceRange(index - 1, index + 2, [result]);
      }

      return symbols[0].toString();
    } catch (e) {
      return 'Error: $e';
    }
  }

  String _extractMultiplicationAndDivision(List<String> symbols) {
    try {
      while (symbols.contains('/') || symbols.contains('x')) {
        final index = symbols.indexWhere(
          (symbol) => symbol == 'x' || symbol == '/',
        );

        if (index <= 0 || index >= symbols.length - 1) break;

        final operator = symbols[index];
        final leftOperand = symbols[index - 1];
        final rightOperand = symbols[index + 1];

        String result;
        if (operator == 'x') {
          result = helper._multiply(leftOperand, rightOperand);
        } else {
          result = helper._divide(leftOperand, rightOperand);
        }

        symbols.replaceRange(index - 1, index + 2, [result]);
      }

      return symbols.join('');
    } catch (e) {
      return 'Error: $e';
    }
  }

  String percentageFunction(String expression) {
    try {
      final List<String> symbols = helper.splitExpression(expression);

      if (symbols.isEmpty) return "0";

      final lastNumber = symbols.last;
      final String result;

      if (helper.isContainsOperator(expression)) {
        symbols.removeLast();
        result =
            symbols.join('') + helper.formatNumber(num.parse(lastNumber) / 100);
      } else {
        result = helper.formatNumber(num.parse(lastNumber) / 100);
      }

      return result;
    } catch (e) {
      return 'Error: $e';
    }
  }

  String calculate(String expression) {
    try {
      if (expression.isEmpty) {
        return "0";
      }

      expression = helper.removeSpaces(expression);

      if (expression.isNotEmpty) {
        final lastChar = expression[expression.length - 1];
        if (helper.isContainsOperator(lastChar)) {
          expression = expression.substring(0, expression.length - 1);
        }
      }

      if (expression.isEmpty) {
        return "0";
      }

      final symbols =
          RegExp(
            r'(\d+\.?\d*)|([+\-x/])',
          ).allMatches(expression).map((match) => match.group(0)!).toList();

      if (symbols.isEmpty) {
        return "0";
      }

      if (symbols.length == 1) {
        return symbols[0];
      }

      List<String> processedSymbols = List.from(symbols);

      if (expression.contains('x') ||
          expression.contains('/') ||
          expression.contains('+') ||
          expression.contains('-')) {
        if (helper.isContainsMultiplicationOrDivision(expression)) {
          // Handle multiplication/division first
          String mdResult = _extractMultiplicationAndDivision(processedSymbols);

          // Re-parse if we need to handle addition/subtraction
          if (helper.isContainsAdditionOrSubtraction(mdResult)) {
            List<String> newSymbols =
                RegExp(
                  r'(\d+\.?\d*)|([+\-])',
                ).allMatches(mdResult).map((match) => match.group(0)!).toList();
            return _calculateAdditionAndSubtraction(newSymbols);
          }
          return mdResult;
        } else {
          return _calculateAdditionAndSubtraction(processedSymbols);
        }
      } else {
        return expression;
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
}
