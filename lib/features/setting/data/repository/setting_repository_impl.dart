

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:youtube_sample_app/core/local/db/provider/setting_box_provider.dart';
import 'package:youtube_sample_app/features/setting/data/repository/setting_repository.dart';

final settingRepositoryProvider = Provider<ISettingRepository>((ref) {
  final box = ref.watch(settingBoxProvider);

  return SettingRepository(box);
  
});

class SettingRepository implements ISettingRepository {
  final Box _box;

  SettingRepository(this._box);
  

  @override
  Future<bool> addToBox<T>(String key, T? value) async {
    await _box.put(key, value);

    return true;

  }

  @override
  Future<T?> getFromBox<T>(String key) async {
    return await _box.get(key);    
  }

}