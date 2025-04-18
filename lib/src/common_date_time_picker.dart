import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A cross-platform date and time picker widget that adapts to iOS and Android platforms.
/// Provides multiple picker variants with platform-specific styling.
/// Follows composition-over-inheritance principle with PickerStyle.
class CommonDateTimePicker {
  /// Show a date picker with platform-specific styling
  static Future<DateTime?> showDatePicker({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    String? title,
    PickerStyle? style,
    DatePickerMode initialDatePickerMode = DatePickerMode.day,
  }) async {
    return _showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      title: title,
      style: style,
      initialDatePickerMode: initialDatePickerMode,
    );
  }

  /// Show a time picker with platform-specific styling
  static Future<TimeOfDay?> showTimePicker({
    required BuildContext context,
    required TimeOfDay initialTime,
    String? title,
    PickerStyle? style,
    bool use24HourFormat = false,
  }) async {
    return _showTimePicker(
      context: context,
      initialTime: initialTime,
      title: title,
      style: style,
      use24HourFormat: use24HourFormat,
    );
  }

  /// Show a date-time picker with platform-specific styling
  static Future<DateTime?> showDateTimePicker({
    required BuildContext context,
    required DateTime initialDateTime,
    required DateTime firstDate,
    required DateTime lastDate,
    String? dateTitle,
    String? timeTitle,
    PickerStyle? style,
    bool use24HourFormat = false,
  }) async {
    // First pick date
    final DateTime? pickedDate = await _showDatePicker(
      context: context,
      initialDate: initialDateTime,
      firstDate: firstDate,
      lastDate: lastDate,
      title: dateTitle ?? 'Select Date',
      style: style,
    );

    if (pickedDate == null) return null;

    // Then pick time
    final TimeOfDay? pickedTime = await _showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialDateTime),
      title: timeTitle ?? 'Select Time',
      style: style,
      use24HourFormat: use24HourFormat,
    );

    if (pickedTime == null) return null;

    // Combine date and time
    return DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );
  }

  /// Show month-year picker with platform-specific styling
  static Future<DateTime?> showMonthYearPicker({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    String? title,
    PickerStyle? style,
  }) async {
    if (Platform.isIOS) {
      return _showCupertinoMonthYearPicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate,
        title: title,
        style: style,
      );
    } else {
      // For Android, we'll use the standard date picker with year mode first
      return _showMaterialMonthYearPicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate,
        title: title,
        style: style,
      );
    }
  }

  /// Show year picker only
  static Future<int?> showYearPicker({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    String? title,
    PickerStyle? style,
  }) async {
    if (Platform.isIOS) {
      final DateTime? result = await _showCupertinoYearPicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate,
        title: title,
        style: style,
      );
      return result?.year;
    } else {
      final DateTime? result = await _showMaterialYearPicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate,
        title: title,
        style: style,
      );
      return result?.year;
    }
  }

  /// Show a date range picker with platform-specific styling
  static Future<DateTimeRange?> showDateRangePicker({
    required BuildContext context,
    DateTime? initialStartDate,
    DateTime? initialEndDate,
    required DateTime firstDate,
    required DateTime lastDate,
    String? title,
    PickerStyle? style,
  }) async {
    if (Platform.isIOS) {
      return _showCupertinoDateRangePicker(
        context: context,
        initialStartDate: initialStartDate,
        initialEndDate: initialEndDate,
        firstDate: firstDate,
        lastDate: lastDate,
        title: title,
        style: style,
      );
    } else {
      return _showMaterialDateRangePicker(
        context: context,
        initialStartDate: initialStartDate,
        initialEndDate: initialEndDate,
        firstDate: firstDate,
        lastDate: lastDate,
        title: title,
        style: style,
      );
    }
  }

  /// Helper method to show the date picker based on platform
  static Future<DateTime?> _showDatePicker({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    String? title,
    PickerStyle? style,
    DatePickerMode initialDatePickerMode = DatePickerMode.day,
  }) async {
    final effectiveStyle = _getEffectiveStyle(context, style);

    if (Platform.isIOS) {
      return _showCupertinoDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate,
        title: title,
        style: effectiveStyle,
      );
    } else {
      return _showMaterialDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate,
        title: title,
        style: effectiveStyle,
        initialDatePickerMode: initialDatePickerMode,
      );
    }
  }

  /// Helper method to show the time picker based on platform
  static Future<TimeOfDay?> _showTimePicker({
    required BuildContext context,
    required TimeOfDay initialTime,
    String? title,
    PickerStyle? style,
    bool use24HourFormat = false,
  }) async {
    final effectiveStyle = _getEffectiveStyle(context, style);

    if (Platform.isIOS) {
      final pickedDateTime = await _showCupertinoTimePicker(
        context: context,
        initialTime: initialTime,
        title: title,
        style: effectiveStyle,
        use24HourFormat: use24HourFormat,
      );
      return pickedDateTime != null
          ? TimeOfDay.fromDateTime(pickedDateTime)
          : null;
    } else {
      return _showMaterialTimePicker(
        context: context,
        initialTime: initialTime,
        title: title,
        style: effectiveStyle,
        use24HourFormat: use24HourFormat,
      );
    }
  }

  /// Get the appropriate style based on platform
  static PickerStyle _getEffectiveStyle(
    BuildContext context,
    PickerStyle? customStyle,
  ) {
    // Default style based on platform
    final textStyle = Platform.isIOS
        ? const TextStyle(
            color: CupertinoColors.label,
            fontSize: 16,
          )
        : const TextStyle(
            color: Colors.black87,
            fontSize: 16,
          );

    final accentColor = Platform.isIOS
        ? CupertinoColors.activeBlue
        : Theme.of(context).primaryColor;

    final backgroundColor =
        Platform.isIOS ? CupertinoColors.systemBackground : Colors.white;

    final PickerStyle defaultStyle = PickerStyle(
      backgroundColor: backgroundColor,
      accentColor: accentColor,
      textStyle: textStyle,
      headerTextStyle: TextStyle(
        color: accentColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      doneButtonText: Platform.isIOS ? 'Done' : 'OK',
      cancelButtonText: 'Cancel',
    );

    // Apply custom style if provided
    return customStyle != null
        ? _mergeStyles(defaultStyle, customStyle)
        : defaultStyle;
  }

  /// Merge base style with override style
  static PickerStyle _mergeStyles(PickerStyle base, PickerStyle override) {
    return base.copyWith(
      backgroundColor: override.backgroundColor,
      accentColor: override.accentColor,
      textStyle: override.textStyle,
      headerTextStyle: override.headerTextStyle,
      doneButtonText: override.doneButtonText,
      cancelButtonText: override.cancelButtonText,
    );
  }

  /// Show Material-style date picker (for Android)
  static Future<DateTime?> _showMaterialDatePicker({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    String? title,
    required PickerStyle style,
    DatePickerMode initialDatePickerMode = DatePickerMode.day,
  }) async {
    return showDialog<DateTime>(
      context: context,
      builder: (context) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: style.accentColor,
                ),
          ),
          child: AlertDialog(
            title: title != null
                ? Text(title, style: style.headerTextStyle)
                : null,
            backgroundColor: style.backgroundColor,
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.4,
              child: CalendarDatePicker(
                initialDate: initialDate,
                firstDate: firstDate,
                lastDate: lastDate,
                initialCalendarMode: initialDatePickerMode,
                onDateChanged: (date) {
                  Navigator.of(context).pop(date);
                },
              ),
            ),
            actions: [
              TextButton(
                child: Text(style.cancelButtonText!),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(initialDate),
                style: TextButton.styleFrom(
                  foregroundColor: style.accentColor,
                ),
                child: Text(style.doneButtonText!),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Show Material-style time picker (for Android)
  static Future<TimeOfDay?> _showMaterialTimePicker({
    required BuildContext context,
    required TimeOfDay initialTime,
    String? title,
    required PickerStyle style,
    bool use24HourFormat = false,
  }) async {
    // Using a basic showTimePicker without additional parameters
    final TimeOfDay? result = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    return result;
  }

  /// Show Material-style month-year picker (for Android)
  static Future<DateTime?> _showMaterialMonthYearPicker({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    String? title,
    PickerStyle? style,
  }) async {
    final effectiveStyle = _getEffectiveStyle(context, style);

    return showDialog<DateTime>(
      context: context,
      builder: (context) {
        DateTime selectedDate = initialDate;

        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: effectiveStyle.accentColor,
                ),
          ),
          child: AlertDialog(
            title: title != null
                ? Text(title, style: effectiveStyle.headerTextStyle)
                : null,
            backgroundColor: effectiveStyle.backgroundColor,
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.3,
              child: CalendarDatePicker(
                initialDate: initialDate,
                firstDate: firstDate,
                lastDate: lastDate,
                initialCalendarMode: DatePickerMode.year,
                onDateChanged: (date) {
                  selectedDate = date;
                },
              ),
            ),
            actions: [
              TextButton(
                child: Text(effectiveStyle.cancelButtonText!),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(DateTime(
                  selectedDate.year,
                  selectedDate.month,
                  1,
                )),
                style: TextButton.styleFrom(
                  foregroundColor: effectiveStyle.accentColor,
                ),
                child: Text(effectiveStyle.doneButtonText!),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Show Material-style year picker (for Android)
  static Future<DateTime?> _showMaterialYearPicker({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    String? title,
    PickerStyle? style,
  }) async {
    final effectiveStyle = _getEffectiveStyle(context, style);

    return showDialog<DateTime>(
      context: context,
      builder: (context) {
        DateTime selectedDate = initialDate;

        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: effectiveStyle.accentColor,
                ),
          ),
          child: AlertDialog(
            title: title != null
                ? Text(title, style: effectiveStyle.headerTextStyle)
                : null,
            backgroundColor: effectiveStyle.backgroundColor,
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.3,
              child: YearPicker(
                firstDate: firstDate,
                lastDate: lastDate,
                selectedDate: initialDate,
                onChanged: (DateTime dateTime) {
                  Navigator.pop(context, dateTime);
                },
              ),
            ),
            actions: [
              TextButton(
                child: Text(effectiveStyle.cancelButtonText!),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Show Material-style date range picker (for Android)
  static Future<DateTimeRange?> _showMaterialDateRangePicker({
    required BuildContext context,
    DateTime? initialStartDate,
    DateTime? initialEndDate,
    required DateTime firstDate,
    required DateTime lastDate,
    String? title,
    PickerStyle? style,
  }) async {
    final effectiveStyle = _getEffectiveStyle(context, style);

    // Use a custom implementation instead of relying on showDateRangePicker parameters
    return showDialog<DateTimeRange>(
      context: context,
      builder: (context) {
        DateTime startDate = initialStartDate ?? DateTime.now();
        DateTime endDate =
            initialEndDate ?? DateTime.now().add(const Duration(days: 7));

        return StatefulBuilder(
          builder: (context, setState) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: Theme.of(context).colorScheme.copyWith(
                      primary: effectiveStyle.accentColor,
                    ),
              ),
              child: AlertDialog(
                title: title != null
                    ? Text(title, style: effectiveStyle.headerTextStyle)
                    : const Text('Select Date Range'),
                backgroundColor: effectiveStyle.backgroundColor,
                content: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Start date
                      ListTile(
                        title: const Text('Start Date'),
                        subtitle: Text(
                            '${startDate.month}/${startDate.day}/${startDate.year}'),
                        onTap: () async {
                          final DateTime? picked =
                              await _showMaterialDatePicker(
                            context: context,
                            initialDate: startDate,
                            firstDate: firstDate,
                            lastDate: endDate,
                            style: effectiveStyle,
                          );
                          if (picked != null) {
                            setState(() {
                              startDate = picked;
                            });
                          }
                        },
                      ),

                      const SizedBox(height: 16),

                      // End date
                      ListTile(
                        title: const Text('End Date'),
                        subtitle: Text(
                            '${endDate.month}/${endDate.day}/${endDate.year}'),
                        onTap: () async {
                          final DateTime? picked =
                              await _showMaterialDatePicker(
                            context: context,
                            initialDate: endDate,
                            firstDate: startDate,
                            lastDate: lastDate,
                            style: effectiveStyle,
                          );
                          if (picked != null) {
                            setState(() {
                              endDate = picked;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    child: Text(effectiveStyle.cancelButtonText!),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context)
                        .pop(DateTimeRange(start: startDate, end: endDate)),
                    style: TextButton.styleFrom(
                      foregroundColor: effectiveStyle.accentColor,
                    ),
                    child: Text(effectiveStyle.doneButtonText!),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  /// Show Cupertino-style date picker (for iOS)
  static Future<DateTime?> _showCupertinoDatePicker({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    String? title,
    required PickerStyle style,
  }) async {
    DateTime? pickedDate = initialDate;

    await showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.4,
          color: style.backgroundColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    child: Text(
                      style.cancelButtonText!,
                      style: const TextStyle(
                        color: CupertinoColors.systemRed,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      pickedDate = null;
                    },
                  ),
                  if (title != null)
                    Text(
                      title,
                      style: style.headerTextStyle,
                    ),
                  CupertinoButton(
                    child: Text(
                      style.doneButtonText!,
                      style: TextStyle(
                        color: style.accentColor,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: initialDate,
                  minimumDate: firstDate,
                  maximumDate: lastDate,
                  onDateTimeChanged: (DateTime dateTime) {
                    pickedDate = dateTime;
                  },
                ),
              ),
            ],
          ),
        );
      },
    );

    return pickedDate;
  }

  /// Show Cupertino-style time picker (for iOS)
  static Future<DateTime?> _showCupertinoTimePicker({
    required BuildContext context,
    required TimeOfDay initialTime,
    String? title,
    required PickerStyle style,
    bool use24HourFormat = false,
  }) async {
    // Create a DateTime to hold the time information
    final DateTime now = DateTime.now();
    DateTime? pickedDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      initialTime.hour,
      initialTime.minute,
    );

    await showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.4,
          color: style.backgroundColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    child: Text(
                      style.cancelButtonText!,
                      style: const TextStyle(
                        color: CupertinoColors.systemRed,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      pickedDateTime = null;
                    },
                  ),
                  if (title != null)
                    Text(
                      title,
                      style: style.headerTextStyle,
                    ),
                  CupertinoButton(
                    child: Text(
                      style.doneButtonText!,
                      style: TextStyle(
                        color: style.accentColor,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: pickedDateTime,
                  use24hFormat: use24HourFormat,
                  onDateTimeChanged: (DateTime dateTime) {
                    pickedDateTime = dateTime;
                  },
                ),
              ),
            ],
          ),
        );
      },
    );

    return pickedDateTime;
  }

  /// Show Cupertino-style month-year picker (for iOS)
  static Future<DateTime?> _showCupertinoMonthYearPicker({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    String? title,
    PickerStyle? style,
  }) async {
    final effectiveStyle = _getEffectiveStyle(context, style);
    DateTime? pickedDate = initialDate;

    await showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.4,
          color: effectiveStyle.backgroundColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    child: Text(
                      effectiveStyle.cancelButtonText!,
                      style: const TextStyle(
                        color: CupertinoColors.systemRed,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      pickedDate = null;
                    },
                  ),
                  if (title != null)
                    Text(
                      title,
                      style: effectiveStyle.headerTextStyle,
                    ),
                  CupertinoButton(
                    child: Text(
                      effectiveStyle.doneButtonText!,
                      style: TextStyle(
                        color: effectiveStyle.accentColor,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.monthYear,
                  initialDateTime: initialDate,
                  minimumDate: firstDate,
                  maximumDate: lastDate,
                  onDateTimeChanged: (DateTime dateTime) {
                    pickedDate = DateTime(dateTime.year, dateTime.month, 1);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );

    return pickedDate;
  }

  /// Show Cupertino-style year picker (for iOS)
  static Future<DateTime?> _showCupertinoYearPicker({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    String? title,
    PickerStyle? style,
  }) async {
    final effectiveStyle = _getEffectiveStyle(context, style);
    DateTime? pickedDate = initialDate;

    await showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.4,
          color: effectiveStyle.backgroundColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    child: Text(
                      effectiveStyle.cancelButtonText!,
                      style: const TextStyle(
                        color: CupertinoColors.systemRed,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      pickedDate = null;
                    },
                  ),
                  if (title != null)
                    Text(
                      title,
                      style: effectiveStyle.headerTextStyle,
                    ),
                  CupertinoButton(
                    child: Text(
                      effectiveStyle.doneButtonText!,
                      style: TextStyle(
                        color: effectiveStyle.accentColor,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 32.0,
                  scrollController: FixedExtentScrollController(
                    initialItem: initialDate.year - firstDate.year,
                  ),
                  onSelectedItemChanged: (int index) {
                    pickedDate = DateTime(firstDate.year + index, 1, 1);
                  },
                  children: List.generate(
                    lastDate.year - firstDate.year + 1,
                    (index) => Center(
                      child: Text(
                        (firstDate.year + index).toString(),
                        style: effectiveStyle.textStyle,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    return pickedDate;
  }

  /// Show Cupertino-style date range picker (for iOS)
  static Future<DateTimeRange?> _showCupertinoDateRangePicker({
    required BuildContext context,
    DateTime? initialStartDate,
    DateTime? initialEndDate,
    required DateTime firstDate,
    required DateTime lastDate,
    String? title,
    PickerStyle? style,
  }) async {
    final effectiveStyle = _getEffectiveStyle(context, style);
    DateTime startDate = initialStartDate ?? DateTime.now();
    DateTime endDate =
        initialEndDate ?? DateTime.now().add(const Duration(days: 7));
    bool confirmed = false;

    await showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.6,
              color: effectiveStyle.backgroundColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoButton(
                        child: Text(
                          effectiveStyle.cancelButtonText!,
                          style: const TextStyle(
                            color: CupertinoColors.systemRed,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      if (title != null)
                        Text(
                          title,
                          style: effectiveStyle.headerTextStyle,
                        ),
                      CupertinoButton(
                        child: Text(
                          effectiveStyle.doneButtonText!,
                          style: TextStyle(
                            color: effectiveStyle.accentColor,
                          ),
                        ),
                        onPressed: () {
                          confirmed = true;
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  // Start date selector
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Text('Start Date:', style: effectiveStyle.textStyle),
                        const SizedBox(width: 8.0),
                        Text(
                          '${startDate.month}/${startDate.day}/${startDate.year}',
                          style: TextStyle(
                            color: effectiveStyle.accentColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: startDate,
                      minimumDate: firstDate,
                      maximumDate: endDate,
                      onDateTimeChanged: (DateTime dateTime) {
                        setState(() {
                          startDate = dateTime;
                          if (endDate.isBefore(startDate)) {
                            endDate = startDate;
                          }
                        });
                      },
                    ),
                  ),
                  // End date selector
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Text('End Date:', style: effectiveStyle.textStyle),
                        const SizedBox(width: 8.0),
                        Text(
                          '${endDate.month}/${endDate.day}/${endDate.year}',
                          style: TextStyle(
                            color: effectiveStyle.accentColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: endDate,
                      minimumDate: startDate,
                      maximumDate: lastDate,
                      onDateTimeChanged: (DateTime dateTime) {
                        setState(() {
                          endDate = dateTime;
                        });
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );

    return confirmed ? DateTimeRange(start: startDate, end: endDate) : null;
  }
}

/// Styling configuration for picker components
class PickerStyle {
  /// Background color of the picker
  final Color? backgroundColor;

  /// Accent color used for highlighting selected items and controls
  final Color? accentColor;

  /// Text style for general text in the picker
  final TextStyle? textStyle;

  /// Text style for header/title text
  final TextStyle? headerTextStyle;

  /// Text for done/confirm button
  final String? doneButtonText;

  /// Text for cancel button
  final String? cancelButtonText;

  const PickerStyle({
    this.backgroundColor,
    this.accentColor,
    this.textStyle,
    this.headerTextStyle,
    this.doneButtonText,
    this.cancelButtonText,
  });

  PickerStyle copyWith({
    Color? backgroundColor,
    Color? accentColor,
    TextStyle? textStyle,
    TextStyle? headerTextStyle,
    String? doneButtonText,
    String? cancelButtonText,
  }) {
    return PickerStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      accentColor: accentColor ?? this.accentColor,
      textStyle: textStyle ?? this.textStyle,
      headerTextStyle: headerTextStyle ?? this.headerTextStyle,
      doneButtonText: doneButtonText ?? this.doneButtonText,
      cancelButtonText: cancelButtonText ?? this.cancelButtonText,
    );
  }
}
