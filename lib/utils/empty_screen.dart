import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../resources/resources.dart';
import 'heights_widths.dart';

class EmptyScreen extends StatelessWidget {
  final String? image;
  final String? title;
  final String? desc;
  final double? scale;
  final double? titleFontSize;
  final double? subtitleFontSize;
  final bool? isSmall;
  final Color? backgroundColor;

  const EmptyScreen(
      {Key? key,this.scale, this.isSmall,this.subtitleFontSize,this.titleFontSize,required this.image, required this.title, required this.desc, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.transparent,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 9.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                h2,
                image==""?const SizedBox():
                Image.asset(
                  image ?? "",
                  scale:scale?? 3.5,
                ),
                h2,
                Text(
                  title ?? "",
                  style: R.textStyles.poppinsRegular(
                    fontSize:subtitleFontSize?? 14.sp,
                    letterSpacing: 0.6,
                    color: R.colors.textColor1,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  desc ?? "",
                  style: R.textStyles.poppinsRegular(
                    fontSize:subtitleFontSize?? 10.sp,
                    letterSpacing: 0.6,
                    color: R.colors.greyColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              if(isSmall==false)  h10
              ],
            ),
          ),
        ),
      ),
    );
  }
}
