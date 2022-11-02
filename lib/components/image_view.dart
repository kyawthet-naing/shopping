import 'package:cached_network_image/cached_network_image.dart';
import 'package:shopping/theme/theme.dart';
import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  final String image;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final BorderRadius? borderRadius;
  const ImageView(
      {super.key,
      required this.image,
      this.width,
      this.height,
      this.fit,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(10),
      ),
      child: CachedNetworkImage(
        imageUrl: image,
        fit: fit ?? BoxFit.fill,
        errorWidget: (context, url, error) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.error, color: Colors.redAccent),
            SizedBox(height: 10),
            Text(
              'Error',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.redAccent),
            )
          ],
        ),
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(AppTheme().primary),
            ),
          ),
        ),
      ),
    );
  }
}
