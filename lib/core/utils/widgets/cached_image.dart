
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smart_sugar/core/utils/extensions.dart';


Widget cachedImage(String? url, String placeHolder,{double? height, Color? color, double? width, BoxFit? fit, AlignmentGeometry? alignment, bool usePlaceholderIfUrlEmpty = true, double? radius}) {
  if (url.validate().isEmpty) {
    return placeHolderWidget(placeHolder: placeHolder,height: height, width: width, fit: fit, alignment: alignment, radius: radius);
  } else if (url.validate().startsWith('http')) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: radius==null?BorderRadius.circular(0.0) :BorderRadius.circular(radius),
      ),
      child: CachedNetworkImage(
        imageUrl: url!,
        height: height,
        width: width,
        fit: BoxFit.cover,
        color: color,
        alignment: alignment as Alignment? ?? Alignment.center,
        progressIndicatorBuilder: (context, url, progress) {
          return placeHolderWidget(placeHolder: placeHolder,height: height, width: width, fit: fit, alignment: alignment, radius: radius);
        },
        errorWidget: (_, s, d) {
          return placeHolderWidget(placeHolder: placeHolder,height: height, width: width, fit: fit, alignment: alignment, radius: radius);
        },
      ),
    );
  } else {
    return Image.asset(placeHolder, height: height, width: width, fit: BoxFit.cover, alignment: alignment ?? Alignment.center).cornerRadiusWithClipRRect(radius ?? 12);
  }
}

Widget placeHolderWidget({double? height, String? placeHolder,double? width, BoxFit? fit, AlignmentGeometry? alignment, double? radius}) {
  return Image.asset(placeHolder!, height: height, width: width, fit: BoxFit.cover, alignment: alignment ?? Alignment.center).cornerRadiusWithClipRRect(radius ?? 12);
}


Widget mBlackEffect(double? width, double? height, {double? radiusValue = 16}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radiusValue ?? 0),
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.black.withValues(alpha: 0.2),
          Colors.black.withValues(alpha: 0.2),
          Colors.black.withValues(alpha: 0.4),
          Colors.black.withValues(alpha: 0.4),
        ],
      ),
    ),
    alignment: Alignment.bottomLeft,
  );
}