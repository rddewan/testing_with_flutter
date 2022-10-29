

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:youtube_sample_app/base/base_consumer_state.dart';
import 'package:youtube_sample_app/features/product/presentation/controller/product_controller.dart';

class ProductListWidget extends ConsumerStatefulWidget {
  const ProductListWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ProductListWidget> createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends BaseConsumerState<ProductListWidget> {
  final ScrollController _scrollController = ScrollController();
  
  @override
  void initState() {    
    super.initState();
     _scrollController.addListener(() {
      // get the max scroll extent and - 310px to load more item before reach the end of scroll
      final maxScrollExtent = _scrollController.position.maxScrollExtent;
      if (_scrollController.position.pixels >= maxScrollExtent) {
        final currentPage = ref.read(productControllerProvider).currentPage;
        final totalPage = ref.read(productControllerProvider).totalPage;
        if (currentPage < totalPage) {  
          ref.read(productControllerProvider.notifier).getProducts();
        }
      }
    });
  }

  @override
  void dispose() {   
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productControllerProvider);    
    
    if (state.products.isEmpty && state.isLoading) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }

    if (state.products.isEmpty) {
      return const Center(child: Center(child: Text('No Product')));
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        AlignedGridView.count(
          itemCount: state.products.length,
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          controller: _scrollController,
          itemBuilder: (context, index) {
            final data = state.products[index];

            return GestureDetector(
              onTap: () {
                
              },
              child: Card(
                elevation: 0,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [ 
                      Image.network(
                        data.thumbnail,
                        height: 150.0,
                        fit: BoxFit.fill,
                      ),
                       const SizedBox(
                        height: 8,
                      ),                     
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius:
                              BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            data.shortDescription,
                            style: textTheme.caption?.copyWith(
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        data.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.caption?.copyWith(
                          color: Colors.black87,
                        ),
                      ),                        
                      
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        if (state.isFetchingNext) ...[
          Positioned(
            bottom: 8,
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator.adaptive(),
                    SizedBox(
                      width: 8,
                    ),
                    Text('loading'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ],
    );

  }
}