import 'package:hive/hive.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class DenomModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? categoryName;
  @HiveField(2)
  String? remark;
  @HiveField(3)
  Map<int, int>? values;
  @HiveField(4)
  String? dateTime;
  @HiveField(5)
  String? total;

  DenomModel(
      {this.id,
      this.categoryName,
      this.values,
      this.remark,
      this.dateTime,
      this.total});
}
