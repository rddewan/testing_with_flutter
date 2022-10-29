import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> with WidgetsBindingObserver {
   Logger  get log => Logger(T.toString());
  
  @override
  void initState() {
    super.initState();
    log.info('$T initState');   
    WidgetsBinding.instance.addObserver(this);
   
  }

  @override
  void dispose() {   
    log.info('$T dispose');
    WidgetsBinding.instance.removeObserver(this); 
    super.dispose();
  }

}