import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({
    required this.imageUrl,
    this.onTap,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    super.key,
  });

  final String imageUrl;
  final VoidCallback? onTap;
  final BoxFit fit;

  /// Shown while loading; defaults to a 120x120 grey box.
  final Widget? placeholder;

  /// Shown on error or empty [imageUrl]; defaults to an error icon.
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final error = errorWidget ?? Icon(Icons.error, color: scheme.outline);

    if (imageUrl.isEmpty) return error;

    return InkWell(
      onTap: onTap,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: fit,
        errorWidget: (_, __, ___) => error,
        progressIndicatorBuilder: (_, __, ___) =>
            placeholder ??
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: scheme.outline,
                  borderRadius: const BorderRadius.all(Radius.circular(2)),
                ),
              ),
            ),
      ),
    );
  }
}
