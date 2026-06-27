// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AttendanceModel _$AttendanceModelFromJson(Map<String, dynamic> json) =>
    _AttendanceModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      checkedAt: DateTime.parse(json['checkedAt'] as String),
      type: $enumDecode(_$AttendanceTypeEnumMap, json['type']),
      status: $enumDecode(_$AttendanceStatusEnumMap, json['status']),
      similarity: (json['similarity'] as num).toDouble(),
      imageBase64: json['imageBase64'] as String?,
      gpsLocation: json['gpsLocation'] as String,
      ipAddress: json['ipAddress'] as String,
    );

Map<String, dynamic> _$AttendanceModelToJson(_AttendanceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'userName': instance.userName,
      'checkedAt': instance.checkedAt.toIso8601String(),
      'type': _$AttendanceTypeEnumMap[instance.type]!,
      'status': _$AttendanceStatusEnumMap[instance.status]!,
      'similarity': instance.similarity,
      'imageBase64': instance.imageBase64,
      'gpsLocation': instance.gpsLocation,
      'ipAddress': instance.ipAddress,
    };

const _$AttendanceTypeEnumMap = {
  AttendanceType.checkIn: 'checkIn',
  AttendanceType.checkOut: 'checkOut',
};

const _$AttendanceStatusEnumMap = {
  AttendanceStatus.onTime: 'onTime',
  AttendanceStatus.late: 'late',
  AttendanceStatus.absent: 'absent',
  AttendanceStatus.early: 'early',
};
