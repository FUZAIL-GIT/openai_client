import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:openai_client/utils/style/app_theme.dart';

class LoadingIndicator {
  final spinkit = SpinKitThreeBounce(
    size: 10,
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppTheme.linearGradient[0],
        ),
      );
    },
  );
}
