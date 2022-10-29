import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:youtube_sample_app/core/error/failure.dart';
import 'package:youtube_sample_app/features/product/application/product_service.dart';
import 'package:youtube_sample_app/features/product/presentation/controller/product_controller.dart';
import 'package:youtube_sample_app/features/product/presentation/state/product_state.dart';

import '../../../../../test_data/product/product_model_test.dart';
import 'product_controller_test.mocks.dart';


@GenerateNiceMocks([MockSpec<ProductService>()])
void main() {
  late ProductService mockProductService;
  late ProviderContainer container;

  setUp(() {
    mockProductService = MockProductService();
   
    container = ProviderContainer(
      overrides: [
        productServiceProvider.overrideWithValue(mockProductService)
      ],
    );

  });

  tearDown(() {
    container.dispose();
  });

  group('Product Controller Test', () {

    test('getProduct success', () async {
      // Setup
      final productModel = await getProductModelTest();
            
      when(mockProductService.getProducts({'perPage':20,'pageNumber':1}))
        .thenAnswer((_) async => Success(productModel));

      final controller = ProductController(mockProductService, const ProductState());
      //debugState get state value that was last set
      expect(controller.debugState.products, []);

      // Run
      controller.getProducts();

      // Verify
      expect(controller.debugState.isLoading, true);
      expect(controller.debugState.isFetchingNext, true);
      verify(mockProductService.getProducts({'perPage':20,'pageNumber':1})).called(1);

      await controller.stream.firstWhere((state) {
        if (state.products.isNotEmpty) return true;
        return false;
      });

     expect(controller.debugState.isLoading, false);
     expect(controller.debugState.isFetchingNext, false);
     expect(controller.debugState.errorMsg, null);
     expect(controller.debugState.products, productModel.product);

    }, timeout: const Timeout(Duration(milliseconds: 1000)),);

    test('getProduct error', () async {
      // Setup
                  
      when(mockProductService.getProducts({'perPage':20,'pageNumber':1}))
        .thenAnswer((_) async => Error(Failure(message: 'something went wrong',stackTrace: StackTrace.fromString('stackTraceString'))));

      final controller = ProductController(mockProductService, const ProductState());
      //debugState get state value that was last set
      expect(controller.debugState.products, []);

      // Run
      controller.getProducts();

      // Verify
      expect(controller.debugState.isLoading, true);
      expect(controller.debugState.isFetchingNext, true);
      verify(mockProductService.getProducts({'perPage':20,'pageNumber':1})).called(1);

      await controller.stream.firstWhere((state) {
        if (state.errorMsg != null) return true;
        return false;
      });

      expect(controller.debugState.isLoading, false);
      expect(controller.debugState.isFetchingNext, false);
      expect(controller.debugState.errorMsg, isNotNull);
      expect(controller.debugState.products, isEmpty);

    }, timeout: const Timeout(Duration(milliseconds: 1000)), );

  });
  
}