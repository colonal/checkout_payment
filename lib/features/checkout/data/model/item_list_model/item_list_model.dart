import 'order_item_model.dart';

class ItemListModel {
  final List<OrderItemModel> order;

  ItemListModel({required this.order});

  factory ItemListModel.fromJson(Map<String, dynamic> json) => ItemListModel(
        order: (json['items'] as List<dynamic>)
            .map((e) => OrderItemModel.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'items': order.map((e) => e.toJson()).toList(),
      };
}
