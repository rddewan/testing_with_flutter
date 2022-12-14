
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_sample_app/common/extension/auto_dispose_cache.dart';
import 'package:youtube_sample_app/common/mixin/input_validation_mixin.dart';
import 'package:youtube_sample_app/core/provider/is_internet_connected_provider.dart';
import 'package:youtube_sample_app/features/register/application/iregister_service.dart';
import 'package:youtube_sample_app/features/register/application/register_service.dart';
import 'package:youtube_sample_app/features/register/data/dto/request/register_request.dart';
import 'package:youtube_sample_app/features/register/presentation/state/register_state.dart';

final registerControllerProvider = StateNotifierProvider.autoDispose<RegisterController,RegisterState>((ref) {
  ref.cacheFor(const Duration(seconds: 5));
  final registerService = ref.watch(registerServiceProvider);
  final connectivity = ref.watch(isInternetConnectedProvider);
  
  return RegisterController(
    registerService, 
    connectivity,
    RegisterState(const AsyncValue.data(false), false, false),
  );
});

class RegisterController extends StateNotifier<RegisterState> with InputValidationMixin{
  final IRegisterService _registerService;
  final InternetConnectionObserver _connectivity;

  RegisterController(this._registerService, this._connectivity ,super.state);

  void register(RegisterRequest request) async {
    final connection = await _connectivity.isNetConnected();
    if (connection) {
      state = state.copyWith(isRegistered: const AsyncValue.loading());
      final result = await _registerService.register(request);

      result.when(
        (error) => state = state.copyWith(
          isRegistered: AsyncValue.error(error, error.stackTrace),
        ), 
        (success) => state = state.copyWith(
          isRegistered: AsyncValue.data(success),),
        );
    }
    
  }

  void setTermsAndCondition(bool value) {
    state = state.copyWith(isTermsAndCondition: value);
  }  
  
}