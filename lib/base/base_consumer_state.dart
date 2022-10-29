
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

abstract class BaseConsumerState<T extends ConsumerStatefulWidget> extends ConsumerState<T> with WidgetsBindingObserver{
  Logger  get log => Logger(T.toString());
  late TextTheme textTheme;

  @override
  void initState() {  
    super.initState(); 
    log.info('$T initState');   
    WidgetsBinding.instance.addObserver(this);
    
  }

  @override
  void didChangeDependencies() {
     textTheme = Theme.of(context).textTheme;
    super.didChangeDependencies();
  }

  @override
  void dispose() { 
    log.info('$T dispose');
    WidgetsBinding.instance.removeObserver(this);   
    super.dispose();
  }
}