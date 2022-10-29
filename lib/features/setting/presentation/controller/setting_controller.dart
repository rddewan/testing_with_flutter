
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_sample_app/core/local/db/hive_box_key.dart';
import 'package:youtube_sample_app/features/setting/application/isetting_service.dart';
import 'package:youtube_sample_app/features/setting/application/setting_service.dart';
import 'package:youtube_sample_app/features/setting/presentation/state/setting_state.dart';

final settingControllerProvider = StateNotifierProvider<SettingController,SettingState>((ref) {
  final settingService = ref.watch(settingServiceProvider);
  
  return SettingController(settingService, const SettingState());

});

class SettingController extends StateNotifier<SettingState> {
  final ISettingService _settingService;

  
  SettingController(this._settingService, super.state);

  void getAccessToken() async {
    final result = await _settingService.getFromBox<String>(accessTokenKey);
    state = state.copyWith(accessToken: result); 
    
  }

  
}