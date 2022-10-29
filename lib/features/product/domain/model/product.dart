
class Product {
    final int id;
    final int categoryId;
    final int brandId;
    final String sku;
    final String name;
    final String shortDescription;
    final String longDescription;
    final String thumbnail;
    final String images;
    final int isActive;    

  Product({
    required this.id, 
    required this.categoryId, 
    required this.brandId, 
    required this.sku, 
    required this.name, 
    required this.shortDescription, 
    required this.longDescription, 
    required this.thumbnail, 
    required this.images, 
    required this.isActive,
    
  });


  @override
  String toString() {
    return 'Product(id: $id, categoryId: $categoryId, brandId: $brandId, sku: $sku, name: $name, shortDescription: $shortDescription, longDescription: $longDescription, thumbnail: $thumbnail, images: $images, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Product &&
      other.id == id &&
      other.categoryId == categoryId &&
      other.brandId == brandId &&
      other.sku == sku &&
      other.name == name &&
      other.shortDescription == shortDescription &&
      other.longDescription == longDescription &&
      other.thumbnail == thumbnail &&
      other.images == images &&
      other.isActive == isActive;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      categoryId.hashCode ^
      brandId.hashCode ^
      sku.hashCode ^
      name.hashCode ^
      shortDescription.hashCode ^
      longDescription.hashCode ^
      thumbnail.hashCode ^
      images.hashCode ^
      isActive.hashCode;
  }
}
