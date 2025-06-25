import 'package:intl/intl.dart';

String formatTimestamp(int timestamp) {
  final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  return DateFormat('dd MMM yyyy • HH:mm').format(date);
}
