class ProductModel {
  ProductModel({
    this.id = 0,
    this.itemId = '',
    this.itemName = '',
    this.barcode = '',
  });

  factory ProductModel.fromJson(Map<String, dynamic> map) => ProductModel(
        id: map['id'],
        itemId: map['item_id'],
        itemName: map['item_name'],
        barcode: map['barcode'],
      );

  final int id;
  final String itemId;
  final String itemName;
  final String barcode;

  Map<String, dynamic> toJson() => {
        'id': id,
        'item_id': itemId,
        'item_name': itemName,
        'barcode': barcode,
      };
}
