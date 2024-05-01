// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DenomModelAdapter extends TypeAdapter<DenomModel> {
  @override
  final int typeId = 1;

  @override
  DenomModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DenomModel(
      id: fields[0] as int?,
      categoryName: fields[1] as String?,
      values: (fields[3] as Map?)?.cast<int, int>(),
      remark: fields[2] as String?,
      dateTime: fields[4] as String?,
      total: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DenomModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.categoryName)
      ..writeByte(2)
      ..write(obj.remark)
      ..writeByte(3)
      ..write(obj.values)
      ..writeByte(4)
      ..write(obj.dateTime)
      ..writeByte(5)
      ..write(obj.total);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DenomModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
