import 'package:hive/hive.dart';
part 'cart.g.dart';

@HiveType(typeId: 2)
class Cart extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String handle;
  @HiveField(2)
  String title;
  @HiveField(3)
  String body;
  @HiveField(4)
  String vendor;
  @HiveField(5)
  String standardizedProductType;
  @HiveField(6)
  String customProductType;
  @HiveField(7)
  String tags;
  @HiveField(8)
  String published;
  @HiveField(9)
  String option1Name;
  @HiveField(10)
  String option1Value;
  @HiveField(11)
  String option2Name;
  @HiveField(12)
  String option2Value;
  @HiveField(13)
  String option3Name;
  @HiveField(14)
  String option3Value;
  @HiveField(15)
  String variantSKU;
  @HiveField(16)
  String variantGrams;
  @HiveField(17)
  String variantInventoryTracker;
  @HiveField(18)
  String variantInventoryQty;
  @HiveField(19)
  String variantInventoryPolicy;
  @HiveField(20)
  String variantFulfillmentService;
  @HiveField(21)
  String variantPrice;
  @HiveField(22)
  String variantCompareAtPrice;
  @HiveField(23)
  String variantRequireShipping;
  @HiveField(24)
  String variantTaxable;
  @HiveField(25)
  String variantBarcode;
  @HiveField(26)
  String imageSrc;
  @HiveField(27)
  String imagePosition;
  @HiveField(28)
  String imageAltText;
  @HiveField(29)
  String giftCard;
  @HiveField(30)
  String seoTitle;
  @HiveField(31)
  String seoDescription;
  @HiveField(32)
  String googleShoppingGoogleProductCategory;
  @HiveField(33)
  String googleShoppingGender;
  @HiveField(34)
  String googleShoppingAgeGroup;
  @HiveField(35)
  String googleShoppingMPN;
  @HiveField(36)
  String googleShoppingAdWordsGrouping;
  @HiveField(37)
  String googleShoppingAdWordsLabels;
  @HiveField(38)
  String googleShoppingCondition;
  @HiveField(39)
  String googleShoppingCustomProduct;
  @HiveField(40)
  String googleShoppingCustomLabel0;
  @HiveField(41)
  String googleShoppingCustomLabel1;
  @HiveField(42)
  String googleShoppingCustomLabel2;
  @HiveField(43)
  String googleShoppingCustomLabel3;
  @HiveField(44)
  String googleShoppingCustomLabel4;
  @HiveField(45)
  String variantImage;
  @HiveField(46)
  String variantWeightUnit;
  @HiveField(47)
  String variantTaxCode;
  @HiveField(48)
  String costPerItem;
  @HiveField(49)
  String priceBahrain;
  @HiveField(50)
  String compareAtPriceBahrain;
  @HiveField(51)
  String priceKuwait;
  @HiveField(52)
  String compareAtPriceKuwait;
  @HiveField(53)
  String priceOman;
  @HiveField(54)
  String compareAtPriceOman;
  @HiveField(55)
  String priceQatar;
  @HiveField(56)
  String compareAtPriceQatar;
  @HiveField(57)
  String priceSaudiArabia;
  @HiveField(58)
  String compareAtPriceSaudiArabia;
  @HiveField(59)
  String status;
  @HiveField(60)
  String isFavorite;
  Cart({
    required this.handle,
    required this.id,
    required this.isFavorite,
    required this.imagePosition,
    required this.body,
    required this.compareAtPriceBahrain,
    required this.compareAtPriceKuwait,
    required this.compareAtPriceOman,
    required this.compareAtPriceQatar,
    required this.compareAtPriceSaudiArabia,
    required this.costPerItem,
    required this.customProductType,
    required this.giftCard,
    required this.googleShoppingAdWordsGrouping,
    required this.googleShoppingAdWordsLabels,
    required this.googleShoppingAgeGroup,
    required this.googleShoppingCondition,
    required this.googleShoppingCustomLabel0,
    required this.googleShoppingCustomLabel1,
    required this.googleShoppingCustomLabel2,
    required this.googleShoppingCustomLabel3,
    required this.googleShoppingCustomLabel4,
    required this.googleShoppingCustomProduct,
    required this.googleShoppingGender,
    required this.googleShoppingGoogleProductCategory,
    required this.googleShoppingMPN,
    required this.imageAltText,
    required this.imageSrc,
    required this.option1Name,
    required this.option1Value,
    required this.option2Name,
    required this.option2Value,
    required this.option3Name,
    required this.option3Value,
    required this.priceBahrain,
    required this.priceKuwait,
    required this.priceOman,
    required this.priceQatar,
    required this.priceSaudiArabia,
    required this.published,
    required this.seoDescription,
    required this.seoTitle,
    required this.standardizedProductType,
    required this.status,
    required this.tags,
    required this.title,
    required this.variantBarcode,
    required this.variantCompareAtPrice,
    required this.variantFulfillmentService,
    required this.variantGrams,
    required this.variantImage,
    required this.variantInventoryPolicy,
    required this.variantInventoryQty,
    required this.variantInventoryTracker,
    required this.variantPrice,
    required this.variantRequireShipping,
    required this.variantSKU,
    required this.variantTaxCode,
    required this.variantTaxable,
    required this.variantWeightUnit,
    required this.vendor,
  });
  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["_id"],
        title: json["Handle"],
        handle: json["Title"],
        body: json["Body (HTML)"],
        vendor: json["Vendor"],
        standardizedProductType: json["Standardized Product Type"],
        customProductType: json["Custom Product Type"],
        tags: json["Tags"],
        published: json["Published"],
        option1Name: json["Option1 Name"],
        option1Value: json["Option1 Value"],
        option2Name: json["Option2 Name"],
        option2Value: json["Option2 Value"],
        option3Name: json["Option3 Name"],
        option3Value: json["Option3 Value"],
        variantSKU: json["Variant SKU"],
        variantGrams: json["Variant Grams"],
        variantInventoryTracker: json["Variant Inventory Tracker"],
        variantInventoryQty: json["Variant Inventory Qty"],
        variantInventoryPolicy: json["Variant Inventory Policy"],
        variantFulfillmentService: json["Variant Fulfillment Service"],
        variantPrice: json["Variant Price"],
        variantCompareAtPrice: json["Variant Compare At Price"],
        variantRequireShipping: json["Variant Requires Shipping"],
        variantTaxable: json["Variant Taxable"],
        variantBarcode: json["Variant Barcode"],
        imageSrc: json["Image Src"],
        imagePosition: json["Image Position"],
        imageAltText: json["Image Alt Text"],
        giftCard: json["Gift Card"],
        seoTitle: json["SEO Title"],
        seoDescription: json["SEO Description"],
        googleShoppingGoogleProductCategory:
            json["Google Shopping / Google Product Category"],
        googleShoppingGender: json["Google Shopping / Gender"],
        googleShoppingAgeGroup: json["Google Shopping / Age Group"],
        googleShoppingMPN: json["Google Shopping / MPN"],
        googleShoppingAdWordsGrouping:
            json["Google Shopping / AdWords Grouping"],
        googleShoppingAdWordsLabels: json["Google Shopping / AdWords Labels"],
        googleShoppingCondition: json["Google Shopping / Condition"],
        googleShoppingCustomProduct: json["Google Shopping / Custom Product"],
        googleShoppingCustomLabel0: json["Google Shopping / Custom Label 0"],
        googleShoppingCustomLabel1: json["Google Shopping / Custom Label 1"],
        googleShoppingCustomLabel2: json["Google Shopping / Custom Label 2"],
        googleShoppingCustomLabel3: json["Google Shopping / Custom Label 3"],
        googleShoppingCustomLabel4: json["Google Shopping / Custom Label 4"],
        variantImage: json["Variant Image"],
        variantWeightUnit: json["Variant Weight Unit"],
        variantTaxCode: json["Variant Tax Code"],
        costPerItem: json["Cost per item"],
        priceBahrain: json["Price / Bahrain"],
        compareAtPriceBahrain: json["Compare At Price / Bahrain"],
        priceKuwait: json["Price / Kuwait"],
        compareAtPriceKuwait: json["Compare At Price / Kuwait"],
        priceOman: json["Price / Oman"],
        compareAtPriceOman: json["Compare At Price / Oman"],
        priceQatar: json["Price / Qatar"],
        compareAtPriceQatar: json["Compare At Price / Qatar"],
        priceSaudiArabia: json["Price / Saudi Arabia"],
        compareAtPriceSaudiArabia: json["Compare At Price / Saudi Arabia"],
        status: json["Status"],
        isFavorite: json["Favorite"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "Handle": handle,
        "Title": title,
        "Body (HTML)": body,
        "Vendor": vendor,
        "Standardized Product Type": standardizedProductType,
        "Custom Product Type": customProductType,
        "Tags": tags,
        "Published": published,
        "Option1 Name": option1Name,
        "Option1 Value": option1Value,
        "Option2 Name": option2Name,
        "Option2 Value": option2Value,
        "Option3 Name": option3Name,
        "Option3 Value": option3Value,
        "Variant SKU": variantSKU,
        "Variant Grams": variantGrams,
        "Variant Inventory Tracker": variantInventoryTracker,
        "Variant Inventory Qty": variantInventoryQty,
        "Variant Inventory Policy": variantInventoryPolicy,
        "Variant Fulfillment Service": variantFulfillmentService,
        "Variant Price": variantPrice,
        "Variant Compare At Price": variantCompareAtPrice,
        "Variant Requires Shipping": variantRequireShipping,
        "Variant Taxable": variantTaxable,
        "Variant Barcode": variantBarcode,
        "Image Src": imageSrc,
        "Image Position": imagePosition,
        "Image Alt Text": imageAltText,
        "Gift Card": giftCard,
        "SEO Title": seoTitle,
        "SEO Description": seoDescription,
        "Google Shopping / Google Product Category":
            googleShoppingGoogleProductCategory,
        "Google Shopping / Gender": googleShoppingGender,
        "Google Shopping / Age Group": googleShoppingAgeGroup,
        "Google Shopping / MPN": googleShoppingMPN,
        "Google Shopping / AdWords Grouping": googleShoppingAdWordsGrouping,
        "Google Shopping / AdWords Labels": googleShoppingAdWordsLabels,
        "Google Shopping / Condition": googleShoppingCondition,
        "Google Shopping / Custom Product": googleShoppingCustomProduct,
        "Google Shopping / Custom Label 0": googleShoppingCustomLabel0,
        "Google Shopping / Custom Label 1": googleShoppingCustomLabel1,
        "Google Shopping / Custom Label 2": googleShoppingCustomLabel2,
        "Google Shopping / Custom Label 3": googleShoppingCustomLabel3,
        "Google Shopping / Custom Label 4": googleShoppingCustomLabel4,
        "Variant Image": variantImage,
        "Variant Weight Unit": variantWeightUnit,
        "Variant Tax Code": variantTaxCode,
        "Cost per item": costPerItem,
        "Price / Bahrain": priceBahrain,
        "Compare At Price / Bahrain": compareAtPriceBahrain,
        "Price / Kuwait": priceKuwait,
        "Compare At Price / Kuwait": compareAtPriceKuwait,
        "Price / Oman": priceOman,
        "Compare At Price / Oman": compareAtPriceOman,
        "Price / Qatar": priceQatar,
        "Compare At Price / Qatar": compareAtPriceQatar,
        "Price / Saudi Arabia": priceSaudiArabia,
        "Compare At Price / Saudi Arabia": compareAtPriceSaudiArabia,
        "Status": status,
        "Favorite": isFavorite,
      };
}
