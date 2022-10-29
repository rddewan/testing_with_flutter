

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:youtube_sample_app/features/product/domain/model/page.dart';
import 'package:youtube_sample_app/features/product/domain/model/product.dart';

part 'product_state.freezed.dart';

@freezed
@immutable
class ProductState with _$ProductState {

  const factory ProductState({
    @Default([])
    List<Product> products,
    Page? page,
    @Default(0)
    int currentPage,
    @Default(0)
    int totalPage,
    @Default(0)
    int total,
    @Default(false)
    bool isLoading,
    @Default(false) 
    bool isFetchingNext,
    String? errorMsg,
  }) = _ProductState;
}