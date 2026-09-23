import 'package:flutter/material.dart';

/// Customizable messages shown around character limits in [RemainingCharCounter].
///
/// Pass a single instance anywhere you need consistent limit copy, e.g.
/// `charLimitTexts: AppCharLimitTexts(reachedMessage: (limit) => '...')`.
class AppCharLimitTexts {
  const AppCharLimitTexts({
    this.reachedMessage,
    this.remainingMessage,
    this.textAlign,
  });

  /// Shown in the warning banner when the user exceeds [charLimit].
  final String Function(int limit)? reachedMessage;

  /// Shown below the field when the user is nearing [charLimit].
  final String Function(int remaining)? remainingMessage;

  /// Text alignment for the remaining-characters message. Defaults to null.
  final TextAlign? textAlign;

  static const defaults = AppCharLimitTexts();

  static const String defaultReachedPrefix = 'Character limit of';
  static const String defaultRemainingSuffix = 'char remaining';

  String buildReachedMessage(int limit) {
    return reachedMessage?.call(limit) ??
        '$defaultReachedPrefix $limit reached';
  }

  String buildRemainingMessage(int remaining) {
    return remainingMessage?.call(remaining) ??
        '$remaining $defaultRemainingSuffix';
  }

  AppCharLimitTexts copyWith({
    String Function(int limit)? reachedMessage,
    String Function(int remaining)? remainingMessage,
    TextAlign? textAlign,
  }) {
    return AppCharLimitTexts(
      reachedMessage: reachedMessage ?? this.reachedMessage,
      remainingMessage: remainingMessage ?? this.remainingMessage,
      textAlign: textAlign ?? this.textAlign,
    );
  }
}
