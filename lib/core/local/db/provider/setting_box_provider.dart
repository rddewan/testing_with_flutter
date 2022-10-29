

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:youtube_sample_app/core/local/db/hive_const.dart';

final settingBoxProvider = Provider<Box>((ref) {
  return Hive.box(settingBox);
});