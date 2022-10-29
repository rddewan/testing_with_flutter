import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final goRouterRefreshStreamProvider = Provider.family<GoRouterRefreshStream,Stream<bool>>((ref,stream) {
  return GoRouterRefreshStream(stream);
});

class GoRouterRefreshStream extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  
  GoRouterRefreshStream(Stream<bool> stream) {
    notifyListeners();
     stream.listen((value) {
      _isLoggedIn = value;
      notifyListeners();

     },
    );
  }
  
}