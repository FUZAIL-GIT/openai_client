import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:openai_client/controller/mode_controller.dart';

import '../../model/mode_model.dart';
import '../../utils/data/data.dart';
import '../../utils/style/app_theme.dart';
import '../../utils/widget_helper.dart';

class CauroselSlider extends StatelessWidget {
  final ModeController modeController;
  const CauroselSlider({super.key, required this.modeController});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: Data.modeList.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        Mode mode = Data.modeList[itemIndex];
        return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              // color: mode.modeColor,
              gradient: AppTheme.linearGradient[itemIndex],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 10.h,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        mode.modeName.toUpperCase(),
                        style: GoogleFonts.adventPro(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                      tab(10),
                      mode.modeIcon,
                    ],
                  ),
                  widgetSpace(10),
                  Text(
                    mode.modeDescription,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ));
      },
      options: CarouselOptions(
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        onPageChanged: (index, onPageChange) {
          modeController.updateIndex(index);
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
