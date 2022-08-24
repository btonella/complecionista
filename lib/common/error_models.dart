import 'package:flutter/material.dart';

showErrorModel(BuildContext context, {String? title, String? error, var data, String? code}) {
  String text = error ?? '';
  if (data is Map && data.isNotEmpty) text += data.toString();
  if (code != null) text += ' statusCode: $code';
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title ?? 'Erro'),
      content: Text(text),
    ),
  );
}
