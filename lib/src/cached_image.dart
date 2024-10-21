// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_common_components/src/skeleton.dart';
import 'package:flutter_common_components/src/utils/icons_utils.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({
    required this.imageUrl,
    super.key,
    this.onTap,
  });

  final String imageUrl;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isNotEmpty) {
      return InkWell(
        onTap: onTap,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          errorWidget: (
            BuildContext context,
            String url,
            Object error,
          ) =>
              Icon(
            IconUtils.error,
            color: Theme.of(context).colorScheme.outline,
          ),
          progressIndicatorBuilder: (
            _,
            String url,
            DownloadProgress widget,
          ) {
            return const Center(
              child: Skeleton(
                height: 120,
                width: 120,
              ),
            );
          },
        ),
      );
    }
    return Icon(
      IconUtils.error,
      color: Theme.of(context).colorScheme.outline,
    );
  }
}
