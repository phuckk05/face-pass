void main() {
  final now = DateTime.now();
  print('Now: $now');
  final iso = now.toIso8601String();
  print('ISO: $iso');
  final parsed = DateTime.parse(iso);
  print('Parsed: $parsed');
  print('Parsed == Now: ${parsed.isAtSameMomentAs(now)}');
  print('Parsed day: ${parsed.day}, Now day: ${now.day}');
}
