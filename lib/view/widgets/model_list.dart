import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:openai_client/utils/data/data.dart';

class ModelList extends StatelessWidget {
  const ModelList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: StaggeredGrid.count(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: [
          for (int i = Data.modeList.length - 1; i >= 0; i--)
            GestureDetector(
                child: Container(
              color: Colors.red,
              child: Column(
                children: [
                  const Text("data"),
                ],
              ),
            )),
        ],
      ),
    );
  }
}
