import 'package:complecionista/common/checkers.dart';
import 'package:flutter/services.dart';

class SmartMaskLogin extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newString = '';
    String newValueWithoutMask = clearGenericMask(newValue.text);
    bool isOnlyNumber = int.tryParse(newValueWithoutMask) != null;

    if (!isOnlyNumber) {
      return newValue;
    } else if (newValueWithoutMask.length == 11) {
      if (validateCpf(newValueWithoutMask)) {
        // is cpf
        newString = '${newValueWithoutMask.substring(0, 3)}.${newValueWithoutMask.substring(3, 6)}.${newValueWithoutMask.substring(6, 9)}-${newValueWithoutMask.substring(9)}';
        return TextEditingValue(
          text: newString,
          selection: TextSelection.collapsed(offset: newString.length),
        );
      }
    } else if (newValueWithoutMask.length > 11) {
      if (validateCnpj(newValueWithoutMask)) {
        newString =
            '${newValueWithoutMask.substring(0, 2)}.${newValueWithoutMask.substring(2, 5)}.${newValueWithoutMask.substring(5, 8)}/${newValueWithoutMask.substring(8, 12)}-${newValueWithoutMask.substring(12)}';
        return TextEditingValue(
          text: newString,
          selection: TextSelection.collapsed(offset: newString.length),
        );
      }
    }

    return newValue;
  }
}
