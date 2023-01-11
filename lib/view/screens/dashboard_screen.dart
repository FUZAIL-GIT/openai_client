import 'package:flutter/material.dart';
import 'package:openai_client/utils/style/app_theme.dart';
import 'package:openai_client/utils/widget_helper.dart';
import 'package:openai_client/view/widgets/auth_key_form.dart';
import 'package:openai_client/view/widgets/header.dart';
import 'package:openai_client/view/widgets/model_list.dart';
import 'package:openai_client/view/widgets/modes_list.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Header(),
              widgetSpace(15),
              const ModeList(),
              widgetSpace(15),
              const AuthKey(),
              widgetSpace(20),
              const ModelList(),
            ],
          ),
        ),
      ),
    );
  }
}
