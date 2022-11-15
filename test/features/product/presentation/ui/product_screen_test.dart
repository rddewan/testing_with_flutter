import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:youtube_sample_app/common/extension/auto_dispose_cache.dart';
import 'package:youtube_sample_app/features/product/application/iproduct_service.dart';
import 'package:youtube_sample_app/features/product/domain/model/product_model.dart';
import 'package:youtube_sample_app/features/product/presentation/controller/product_controller.dart';
import 'package:youtube_sample_app/features/product/presentation/state/product_state.dart';
import 'package:youtube_sample_app/features/product/presentation/ui/product_screen.dart';

import '../../../../../test_data/product/product_model_test.dart';
import 'product_screen_test.mocks.dart';

@GenerateNiceMocks([MockSpec<IProductService>()])

void main() {
  late IProductService mockIProductService;
  late Map<String,dynamic> query;
  late ProductModel productModel;

  setUp(() async {
    mockIProductService = MockIProductService();
    query = {'perPage':20,'pageNumber':1};
    productModel = await getProductModelTest();

  });


  testWidgets('product list screen ...', (tester) async {

    when(mockIProductService.getProducts(query))
      .thenAnswer((_) async => Success(productModel));

    final mockProductControllerProvider = StateNotifierProvider.autoDispose<ProductController,ProductState>((ref) {
      ref.cacheFor(const Duration(seconds: 30)); 
      
      return ProductController(mockIProductService, const ProductState());
    });

    //tester.binding.window.physicalSizeTestValue = const Size(1920, 1080);

    await mockNetworkImages(() async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            // ignore: deprecated_member_use
            productControllerProvider.overrideWithProvider(mockProductControllerProvider)
          ],
          child: const MaterialApp(
            home: ProductScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();


      expect(find.byType(Card), findsNWidgets(6));
      final size = tester.binding.window.physicalSize.toString();
      final gridSize = tester.getSize(find.byType(AlignedGridView)).toString();
      debugPrint(size);
      debugPrint(gridSize);
      expect(find.text('I wonder what.'), findsOneWidget);
      expect(find.text("I'm doubtful."), findsNothing);

      await tester.drag(find.byType(AlignedGridView), const Offset(0, -200));
      await tester.pumpAndSettle();
      expect(find.text("I'm doubtful."), findsOneWidget);

      await tester.dragUntilVisible(
        find.text("All this time."), 
        find.byType(AlignedGridView), 
        const Offset(0, -100),
      );

    });

    

    
  });
}