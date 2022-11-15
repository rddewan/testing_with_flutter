// Mocks generated by Mockito 5.3.2 from annotations
// in youtube_sample_app/test/features/product/presentation/ui/product_screen_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:multiple_result/multiple_result.dart' as _i2;
import 'package:youtube_sample_app/core/error/failure.dart' as _i5;
import 'package:youtube_sample_app/features/product/application/iproduct_service.dart'
    as _i3;
import 'package:youtube_sample_app/features/product/domain/model/product_model.dart'
    as _i6;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeResult_0<E, S> extends _i1.SmartFake implements _i2.Result<E, S> {
  _FakeResult_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [IProductService].
///
/// See the documentation for Mockito's code generation for more information.
class MockIProductService extends _i1.Mock implements _i3.IProductService {
  @override
  _i4.Future<_i2.Result<_i5.Failure, _i6.ProductModel>> getProducts(
          Map<String, dynamic>? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #getProducts,
          [query],
        ),
        returnValue:
            _i4.Future<_i2.Result<_i5.Failure, _i6.ProductModel>>.value(
                _FakeResult_0<_i5.Failure, _i6.ProductModel>(
          this,
          Invocation.method(
            #getProducts,
            [query],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Result<_i5.Failure, _i6.ProductModel>>.value(
                _FakeResult_0<_i5.Failure, _i6.ProductModel>(
          this,
          Invocation.method(
            #getProducts,
            [query],
          ),
        )),
      ) as _i4.Future<_i2.Result<_i5.Failure, _i6.ProductModel>>);
}
