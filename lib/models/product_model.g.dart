// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 1;

  @override
  ProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModel(
      handle: fields[1] as String,
      id: fields[0] as String,
      isFavorite: fields[60] as String,
      imagePosition: fields[27] as String,
      body: fields[3] as String,
      compareAtPriceBahrain: fields[50] as String,
      compareAtPriceKuwait: fields[52] as String,
      compareAtPriceOman: fields[54] as String,
      compareAtPriceQatar: fields[56] as String,
      compareAtPriceSaudiArabia: fields[58] as String,
      costPerItem: fields[48] as String,
      customProductType: fields[6] as String,
      giftCard: fields[29] as String,
      googleShoppingAdWordsGrouping: fields[36] as String,
      googleShoppingAdWordsLabels: fields[37] as String,
      googleShoppingAgeGroup: fields[34] as String,
      googleShoppingCondition: fields[38] as String,
      googleShoppingCustomLabel0: fields[40] as String,
      googleShoppingCustomLabel1: fields[41] as String,
      googleShoppingCustomLabel2: fields[42] as String,
      googleShoppingCustomLabel3: fields[43] as String,
      googleShoppingCustomLabel4: fields[44] as String,
      googleShoppingCustomProduct: fields[39] as String,
      googleShoppingGender: fields[33] as String,
      googleShoppingGoogleProductCategory: fields[32] as String,
      googleShoppingMPN: fields[35] as String,
      imageAltText: fields[28] as String,
      imageSrc: fields[26] as String,
      option1Name: fields[9] as String,
      option1Value: fields[10] as String,
      option2Name: fields[11] as String,
      option2Value: fields[12] as String,
      option3Name: fields[13] as String,
      option3Value: fields[14] as String,
      priceBahrain: fields[49] as String,
      priceKuwait: fields[51] as String,
      priceOman: fields[53] as String,
      priceQatar: fields[55] as String,
      priceSaudiArabia: fields[57] as String,
      published: fields[8] as String,
      seoDescription: fields[31] as String,
      seoTitle: fields[30] as String,
      standardizedProductType: fields[5] as String,
      status: fields[59] as String,
      tags: fields[7] as String,
      title: fields[2] as String,
      variantBarcode: fields[25] as String,
      variantCompareAtPrice: fields[22] as String,
      variantFulfillmentService: fields[20] as String,
      variantGrams: fields[16] as String,
      variantImage: fields[45] as String,
      variantInventoryPolicy: fields[19] as String,
      variantInventoryQty: fields[18] as String,
      variantInventoryTracker: fields[17] as String,
      variantPrice: fields[21] as String,
      variantRequireShipping: fields[23] as String,
      variantSKU: fields[15] as String,
      variantTaxCode: fields[47] as String,
      variantTaxable: fields[24] as String,
      variantWeightUnit: fields[46] as String,
      vendor: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(61)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.handle)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.body)
      ..writeByte(4)
      ..write(obj.vendor)
      ..writeByte(5)
      ..write(obj.standardizedProductType)
      ..writeByte(6)
      ..write(obj.customProductType)
      ..writeByte(7)
      ..write(obj.tags)
      ..writeByte(8)
      ..write(obj.published)
      ..writeByte(9)
      ..write(obj.option1Name)
      ..writeByte(10)
      ..write(obj.option1Value)
      ..writeByte(11)
      ..write(obj.option2Name)
      ..writeByte(12)
      ..write(obj.option2Value)
      ..writeByte(13)
      ..write(obj.option3Name)
      ..writeByte(14)
      ..write(obj.option3Value)
      ..writeByte(15)
      ..write(obj.variantSKU)
      ..writeByte(16)
      ..write(obj.variantGrams)
      ..writeByte(17)
      ..write(obj.variantInventoryTracker)
      ..writeByte(18)
      ..write(obj.variantInventoryQty)
      ..writeByte(19)
      ..write(obj.variantInventoryPolicy)
      ..writeByte(20)
      ..write(obj.variantFulfillmentService)
      ..writeByte(21)
      ..write(obj.variantPrice)
      ..writeByte(22)
      ..write(obj.variantCompareAtPrice)
      ..writeByte(23)
      ..write(obj.variantRequireShipping)
      ..writeByte(24)
      ..write(obj.variantTaxable)
      ..writeByte(25)
      ..write(obj.variantBarcode)
      ..writeByte(26)
      ..write(obj.imageSrc)
      ..writeByte(27)
      ..write(obj.imagePosition)
      ..writeByte(28)
      ..write(obj.imageAltText)
      ..writeByte(29)
      ..write(obj.giftCard)
      ..writeByte(30)
      ..write(obj.seoTitle)
      ..writeByte(31)
      ..write(obj.seoDescription)
      ..writeByte(32)
      ..write(obj.googleShoppingGoogleProductCategory)
      ..writeByte(33)
      ..write(obj.googleShoppingGender)
      ..writeByte(34)
      ..write(obj.googleShoppingAgeGroup)
      ..writeByte(35)
      ..write(obj.googleShoppingMPN)
      ..writeByte(36)
      ..write(obj.googleShoppingAdWordsGrouping)
      ..writeByte(37)
      ..write(obj.googleShoppingAdWordsLabels)
      ..writeByte(38)
      ..write(obj.googleShoppingCondition)
      ..writeByte(39)
      ..write(obj.googleShoppingCustomProduct)
      ..writeByte(40)
      ..write(obj.googleShoppingCustomLabel0)
      ..writeByte(41)
      ..write(obj.googleShoppingCustomLabel1)
      ..writeByte(42)
      ..write(obj.googleShoppingCustomLabel2)
      ..writeByte(43)
      ..write(obj.googleShoppingCustomLabel3)
      ..writeByte(44)
      ..write(obj.googleShoppingCustomLabel4)
      ..writeByte(45)
      ..write(obj.variantImage)
      ..writeByte(46)
      ..write(obj.variantWeightUnit)
      ..writeByte(47)
      ..write(obj.variantTaxCode)
      ..writeByte(48)
      ..write(obj.costPerItem)
      ..writeByte(49)
      ..write(obj.priceBahrain)
      ..writeByte(50)
      ..write(obj.compareAtPriceBahrain)
      ..writeByte(51)
      ..write(obj.priceKuwait)
      ..writeByte(52)
      ..write(obj.compareAtPriceKuwait)
      ..writeByte(53)
      ..write(obj.priceOman)
      ..writeByte(54)
      ..write(obj.compareAtPriceOman)
      ..writeByte(55)
      ..write(obj.priceQatar)
      ..writeByte(56)
      ..write(obj.compareAtPriceQatar)
      ..writeByte(57)
      ..write(obj.priceSaudiArabia)
      ..writeByte(58)
      ..write(obj.compareAtPriceSaudiArabia)
      ..writeByte(59)
      ..write(obj.status)
      ..writeByte(60)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
