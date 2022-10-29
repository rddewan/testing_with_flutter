
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_sample_app/features/setting/application/isetting_service.dart';
import 'package:youtube_sample_app/features/setting/data/repository/setting_repository.dart';
import 'package:youtube_sample_app/features/setting/data/repository/setting_repository_impl.dart';

final settingServiceProvider = Provider<ISettingService>((ref) {
  final settingRepository = ref.watch(settingRepositoryProvider);

  return SettingService(settingRepository);

});

class SettingService implements ISettingService {
  final ISettingRepository _settingRepository;

  SettingService(this._settingRepository);

  

  @override
  Future<bool> addToBox<T>(String key, T? value) async {
    final result = await _settingRepository.addToBox(key, value);

    return result;
    
  }

  @override
  Future<T?> getFromBox<T>(String key) async {
    return await _settingRepository.getFromBox(key);    
  }

}