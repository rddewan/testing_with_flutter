
import 'package:flutter_riverpod/flutter_riverpod.dart';

final baseUrlProvider = Provider.autoDispose<String>((ref) {
  return 'https://bazar.rdewan.dev/';
});