import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

/// A cross-platform image widget with support for multiple image sources,
/// placeholders, error handling, and platform-specific optimizations.
///
/// Usage examples:
/// ```dart
/// // Network image with placeholder and error widget
/// CommonImage.network(
///   url: 'https://example.com/image.jpg',
///   placeholder: CircularProgressIndicator(),
///   errorWidget: Icon(Icons.error),
/// )
///
/// // Asset image with custom fit and size
/// CommonImage.asset(
///   path: 'assets/images/logo.png',
///   fit: BoxFit.cover,
///   width: 100,
///   height: 100,
/// )
///
/// // File image with circular shape
/// CommonImage.file(
///   file: File('/path/to/image.jpg'),
///   shape: ImageShape.circle,
/// )
/// ```
class CommonImage extends StatelessWidget {
  /// Private constructor - forces use of factory constructors
  const CommonImage._({
    required this.imageProvider,
    this.placeholder,
    this.errorWidget,
    this.width,
    this.height,
    this.fit,
    this.shape = ImageShape.rectangle,
    this.borderRadius,
    this.border,
    this.color,
    this.colorBlendMode,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
  });

  // Image properties
  final ImageProvider imageProvider;
  final Widget? placeholder;
  final Widget? errorWidget;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final ImageShape shape;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final Color? color;
  final BlendMode? colorBlendMode;
  final Alignment alignment;
  final ImageRepeat repeat;

  // Factory constructor for network image
  factory CommonImage.network({
    required String url,
    Widget? placeholder,
    Widget? errorWidget,
    double? width,
    double? height,
    BoxFit? fit,
    ImageShape shape = ImageShape.rectangle,
    BorderRadius? borderRadius,
    BoxBorder? border,
    Color? color,
    BlendMode? colorBlendMode,
    Alignment alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
  }) {
    return CommonImage._(
      imageProvider: NetworkImage(url),
      placeholder: placeholder,
      errorWidget: errorWidget,
      width: width,
      height: height,
      fit: fit,
      shape: shape,
      borderRadius: borderRadius,
      border: border,
      color: color,
      colorBlendMode: colorBlendMode,
      alignment: alignment,
      repeat: repeat,
    );
  }

  // Factory constructor for asset image
  factory CommonImage.asset({
    required String path,
    Widget? placeholder,
    Widget? errorWidget,
    double? width,
    double? height,
    BoxFit? fit,
    ImageShape shape = ImageShape.rectangle,
    BorderRadius? borderRadius,
    BoxBorder? border,
    Color? color,
    BlendMode? colorBlendMode,
    Alignment alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
  }) {
    return CommonImage._(
      imageProvider: AssetImage(path),
      placeholder: placeholder,
      errorWidget: errorWidget,
      width: width,
      height: height,
      fit: fit,
      shape: shape,
      borderRadius: borderRadius,
      border: border,
      color: color,
      colorBlendMode: colorBlendMode,
      alignment: alignment,
      repeat: repeat,
    );
  }

  // Factory constructor for file image
  factory CommonImage.file({
    required File file,
    Widget? placeholder,
    Widget? errorWidget,
    double? width,
    double? height,
    BoxFit? fit,
    ImageShape shape = ImageShape.rectangle,
    BorderRadius? borderRadius,
    BoxBorder? border,
    Color? color,
    BlendMode? colorBlendMode,
    Alignment alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
  }) {
    return CommonImage._(
      imageProvider: FileImage(file),
      placeholder: placeholder,
      errorWidget: errorWidget,
      width: width,
      height: height,
      fit: fit,
      shape: shape,
      borderRadius: borderRadius,
      border: border,
      color: color,
      colorBlendMode: colorBlendMode,
      alignment: alignment,
      repeat: repeat,
    );
  }

  // Factory constructor for memory image
  factory CommonImage.memory({
    required Uint8List bytes,
    Widget? placeholder,
    Widget? errorWidget,
    double? width,
    double? height,
    BoxFit? fit,
    ImageShape shape = ImageShape.rectangle,
    BorderRadius? borderRadius,
    BoxBorder? border,
    Color? color,
    BlendMode? colorBlendMode,
    Alignment alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
  }) {
    return CommonImage._(
      imageProvider: MemoryImage(bytes),
      placeholder: placeholder,
      errorWidget: errorWidget,
      width: width,
      height: height,
      fit: fit,
      shape: shape,
      borderRadius: borderRadius,
      border: border,
      color: color,
      colorBlendMode: colorBlendMode,
      alignment: alignment,
      repeat: repeat,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: shape == ImageShape.circle ? null : borderRadius,
        border: border,
        shape:
            shape == ImageShape.circle ? BoxShape.circle : BoxShape.rectangle,
      ),
      child: ClipRRect(
        borderRadius: shape == ImageShape.circle
            ? BorderRadius.circular((width ?? height ?? 0) / 2)
            : borderRadius ?? BorderRadius.zero,
        child: Image(
          image: imageProvider,
          width: width,
          height: height,
          fit: fit,
          color: color,
          colorBlendMode: colorBlendMode,
          alignment: alignment,
          repeat: repeat,
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded) {
              return child;
            }
            return frame == null ? placeholder ?? const SizedBox() : child;
          },
          errorBuilder: (context, error, stackTrace) {
            return errorWidget ?? const Icon(Icons.error);
          },
        ),
      ),
    );
  }
}

/// Supported image shapes
enum ImageShape {
  rectangle,
  circle,
}
