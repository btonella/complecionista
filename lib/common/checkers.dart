// ignore_for_file: constant_identifier_names

const List<String> BLACK_LIST_LENGTH_11 = [
  '00000000000',
  '11111111111',
  '22222222222',
  '33333333333',
  '44444444444',
  '55555555555',
  '66666666666',
  '77777777777',
  '88888888888',
  '99999999999',
];

const List<String> BLACK_LIST_LENGTH_14 = [
  '00000000000000',
  '11111111111111',
  '22222222222222',
  '33333333333333',
  '44444444444444',
  '55555555555555',
  '66666666666666',
  '77777777777777',
  '88888888888888',
  '99999999999999',
];

bool validateCpf(String cpf) {
  if (cpf.isNotEmpty && cpf.length == 11 && int.tryParse(cpf) != null && !BLACK_LIST_LENGTH_11.contains(cpf)) {
    int sum = 0;
    int rest;
    for (var i = 1; i <= 9; i += 1) {
      sum += (int.tryParse(cpf.substring(i - 1, i), radix: 10)! * (11 - i));
    }
    rest = (sum * 10) % 11;
    if ((rest == 10) || (rest == 11)) rest = 0;
    if (rest != int.tryParse(cpf.substring(9, 10), radix: 10)) return false;
    sum = 0;
    for (var i = 1; i <= 10; i += 1) {
      sum += int.tryParse(cpf.substring(i - 1, i), radix: 10)! * (12 - i);
    }
    rest = (sum * 10) % 11;
    if ((rest == 10) || (rest == 11)) rest = 0;
    if (rest != int.tryParse(cpf.substring(10, 11), radix: 10)) return false;
    return true;
  }
  return false;
}

bool validateCnpj(String cnpj) {
  if (cnpj.isNotEmpty && cnpj.length == 14 && int.tryParse(cnpj) != null && !BLACK_LIST_LENGTH_14.contains(cnpj)) return true;
  return false;
}

String clearGenericMask(String text) {
  return text.replaceAll('(', '').replaceAll(')', '').replaceAll('.', '').replaceAll('-', '').replaceAll('/', '').replaceAll(' ', '');
}
