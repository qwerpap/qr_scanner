import 'package:qr_scanner/l10n/app_localizations.dart';

class TimeFormatter {
  TimeFormatter._();

  static String formatScannedTime(
    DateTime scannedAt,
    AppLocalizations localizations,
  ) {
    final now = DateTime.now();
    final difference = now.difference(scannedAt);

    if (difference.inSeconds < 60) {
      return localizations.justNow;
    }

    if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return minutes == 1
          ? localizations.minuteAgo(minutes)
          : localizations.minutesAgo(minutes);
    }

    if (difference.inHours < 24) {
      final hours = difference.inHours;
      return hours == 1
          ? localizations.hourAgo(hours)
          : localizations.hoursAgo(hours);
    }

    if (difference.inDays < 7) {
      final days = difference.inDays;
      return days == 1
          ? localizations.dayAgo(days)
          : localizations.daysAgo(days);
    }

    return _formatDate(scannedAt, localizations);
  }

  static String _formatDate(DateTime date, AppLocalizations localizations) {
    final months = [
      localizations.monthJan,
      localizations.monthFeb,
      localizations.monthMar,
      localizations.monthApr,
      localizations.monthMay,
      localizations.monthJun,
      localizations.monthJul,
      localizations.monthAug,
      localizations.monthSep,
      localizations.monthOct,
      localizations.monthNov,
      localizations.monthDec,
    ];

    final day = date.day;
    final month = months[date.month - 1];
    final year = date.year;

    return '$month $day, $year';
  }
}
