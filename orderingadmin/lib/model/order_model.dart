import 'package:orderingadmin/model/product_model.dart';

class Order {
  int? order_id;
  int? kiosk_id;
  String? kiosk_type;
  String? order_code;
  String? or_number;
  int? queue;
  String? order_by;
  int? received_by;
  DateTime? order_date;
  List<Product>? items;

  Order({
    this.order_id,
    this.kiosk_id,
    this.kiosk_type,
    this.order_code,
    this.or_number,
    this.queue,
    this.order_by,
    this.received_by,
    this.order_date,
    this.items,
  });

  Order.fromJson(Map<String, dynamic> json) {
    this.order_id = json['order_id'];
    this.kiosk_id = json['kiosk_id'];
    this.kiosk_type = json['kiosk_type'] ?? '';
    this.order_code = json['order_code'];
    this.or_number = json['or_number'];
    this.queue = json['queue'];
    this.order_by = json['order_by'];
    this.received_by = json['received_by'];
    this.order_date = DateTime.parse(json['order_date']);
    this.items = (json['items'] as List)
        .map((i) => Product.fromJson(i))
        .toList(); // json['items'] as List<Product>;
  }

  Map<String, dynamic> toJson() => {
        'order_id': order_id,
        'kiosk_id': kiosk_id,
        'kiosk_type': kiosk_type,
        'order_code': order_code,
        'or_number': or_number,
        'queue': queue,
        'order_by': order_by,
        'received_by': received_by,
        'order_date': order_date,
        'items': items,
      };
}
