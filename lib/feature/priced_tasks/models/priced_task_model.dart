import 'package:hive/hive.dart';

part 'priced_task_model.g.dart';

@HiveType(typeId: 5)
class PricedTaskModel extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  int qty;
  @HiveField(2)
  int price;
  @HiveField(3)
  int parentId;
  @HiveField(4)
  int id;
  @HiveField(5)
  DateTime noteDate;
  @HiveField(6)
  int totalPrice;

  PricedTaskModel({
    this.name = '',
    this.qty = 0,
    this.price = 0,
    this.parentId = -1,
    this.id = -1,
    this.totalPrice = 0,
    required this.noteDate,
  });

  PricedTaskModel copyWith({
    String? name,
    int? qty,
    int? price,
    int? parentId,
    int? id,
    DateTime? noteDate,
    int? totalPrice,
  }) {
    return PricedTaskModel(
      name: name ?? this.name,
      qty: qty ?? this.qty,
      price: price ?? this.price,
      parentId: parentId ?? this.parentId,
      id: id ?? this.id,
      noteDate: noteDate ?? this.noteDate,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}
