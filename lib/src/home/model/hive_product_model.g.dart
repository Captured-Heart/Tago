// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductsModelAdapter extends TypeAdapter<ProductsModel> {
  @override
  final int typeId = 1;

  @override
  ProductsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductsModel(
      id: fields[0] as int?,
      name: fields[1] as String?,
      label: fields[2] as String?,
      description: fields[3] as String?,
      productImages: (fields[4] as List?)?.cast<dynamic>(),
      productSpecification: (fields[5] as List?)?.cast<dynamic>(),
      productReview: (fields[6] as List?)?.cast<dynamic>(),
      productTags: (fields[7] as List?)?.cast<dynamic>(),
      relatedProducts: (fields[8] as List?)?.cast<dynamic>(),
      categoryId: fields[9] as int?,
      subCategoryId: fields[10] as int?,
      amount: fields[11] as int?,
      brand: (fields[12] as Map?)?.cast<String, dynamic>(),
      category: fields[13] as CategoriesModel?,
      subCategory: fields[14] as SubCategoriesModel?,
      originalAmount: fields[15] as int?,
      savedPerc: fields[16] as double?,
      availableQuantity: fields[17] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductsModel obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.label)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.productImages)
      ..writeByte(5)
      ..write(obj.productSpecification)
      ..writeByte(6)
      ..write(obj.productReview)
      ..writeByte(7)
      ..write(obj.productTags)
      ..writeByte(8)
      ..write(obj.relatedProducts)
      ..writeByte(9)
      ..write(obj.categoryId)
      ..writeByte(10)
      ..write(obj.subCategoryId)
      ..writeByte(11)
      ..write(obj.amount)
      ..writeByte(12)
      ..write(obj.brand)
      ..writeByte(13)
      ..write(obj.category)
      ..writeByte(14)
      ..write(obj.subCategory)
      ..writeByte(15)
      ..write(obj.originalAmount)
      ..writeByte(16)
      ..write(obj.savedPerc)
      ..writeByte(17)
      ..write(obj.availableQuantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
