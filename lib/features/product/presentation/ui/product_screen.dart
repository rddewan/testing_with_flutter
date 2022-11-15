
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_sample_app/common/widget/app_scaffold.dart';
import 'package:youtube_sample_app/features/product/presentation/controller/product_controller_notifier.dart';
import 'package:youtube_sample_app/features/product/presentation/ui/widget/product_list_widget.dart';

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  @override
  void initState() {   
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(productControllerNotifierProvider.notifier).getProducts();
    });
  }
  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      title: Text('Product'), 
      slivers: [
        SliverFillRemaining(
          child: ProductListWidget(),
        )

      ],
      
    );
  }
}