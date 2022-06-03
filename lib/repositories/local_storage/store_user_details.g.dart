// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_user_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserLocalDataAdapter extends TypeAdapter<UserLocalData> {
  @override
  final int typeId = 0;

  @override
  UserLocalData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserLocalData(
      token: fields[0] as String,
      id: fields[1] as String,
      firstName: fields[2] as String,
      secondName: fields[3] as String,
      age: fields[4] as int,
      gender: fields[5] as String,
      email: fields[6] as String,
      phone: fields[7] as String,
      blood: fields[8] as String,
      password: fields[9] as String,
      image: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserLocalData obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.token)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.firstName)
      ..writeByte(3)
      ..write(obj.secondName)
      ..writeByte(4)
      ..write(obj.age)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.email)
      ..writeByte(7)
      ..write(obj.phone)
      ..writeByte(8)
      ..write(obj.blood)
      ..writeByte(9)
      ..write(obj.password)
      ..writeByte(10)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserLocalDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
