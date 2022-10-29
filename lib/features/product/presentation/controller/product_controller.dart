
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_sample_app/common/extension/auto_dispose_cache.dart';
import 'package:youtube_sample_app/features/product/application/iproduct_service.dart';
import 'package:youtube_sample_app/features/product/application/product_service.dart';
import 'package:youtube_sample_app/features/product/presentation/state/product_state.dart';

final productControllerProvider = StateNotifierProvider.autoDispose<ProductController,ProductState>((ref) {
  ref.cacheFor(const Duration(seconds: 30)); 
  final productService = ref.watch(productServiceProvider);

  return ProductController(productService, const ProductState());
});

class ProductController extends StateNotifier<ProductState> {
  final IProductService _productService;
  ProductController(this._productService, super.state);

  void getProducts() async {
    // Cancel api call if it's already fetching the data
    if (state.isFetchingNext) return;

    state = state.copyWith(isFetchingNext: true, isLoading: true);
    // get the current list
    final oldData = [...state.products]; 

    final pageNumber = state.currentPage == 0 ? 1 : state.currentPage +1;

    final  Map<String,dynamic> query = {'perPage':20,'pageNumber':pageNumber};

    final result = await _productService.getProducts(query);
    result.when(
      (error) => state = state.copyWith(
        errorMsg: error.message,
        isFetchingNext: false,
        isLoading: false,
      ), 
      (success) {
        state = state.copyWith(
          products: [...oldData, ...success.product], 
          page: success.page,
          currentPage: success.page.currentPage,
          totalPage: success.page.lastPage,
          total: success.page.total,
          isFetchingNext: false,
          isLoading: false,
          errorMsg: null,
        );
      },
    );
  }

}