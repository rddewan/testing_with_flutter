
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_sample_app/common/widget/dialog/confirm_dialog.dart';
import 'package:youtube_sample_app/common/widget/widget_key.dart';
import 'package:youtube_sample_app/features/auth/presentation/ui/controller/auth_controller.dart';


class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> with ConfirmDialog {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('Setting Screen',),
            ElevatedButton(     
              key: btnLogoutKey,         
              onPressed: () {
                showConfirmDialog(
                  context: context,
                  title: 'Do you want to logout?',
                  msg: 'You will be logout from app',
                  btnNoText: 'No',
                  btnYesText: 'Yes',
                  onYesTap: () {
                    ref.read(authControllerProvider.notifier).logout();
                    final navigator = Navigator.of(context,rootNavigator: true);
                    if (navigator.canPop()) {
                      navigator.pop();
                    }
                    
                  },
                  onNoTap: (() {
                    final navigator = Navigator.of(context,rootNavigator: true);
                    if (navigator.canPop()) {
                      navigator.pop();
                    }
                  }
                  ),
                );              
                 

              }, 
            child: const Text('Logout'),),
          ],
        ),
      ),
    );
  }
}