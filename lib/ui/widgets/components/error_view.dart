import 'package:flutter/material.dart';

import '../../theme.dart';

class ErrorView extends StatelessWidget {
  final String message;
  const ErrorView({
    Key? key,
    this.message = "Something went wrong",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(color: AppColors.error),
      ),
    );
    ;
  }
}
