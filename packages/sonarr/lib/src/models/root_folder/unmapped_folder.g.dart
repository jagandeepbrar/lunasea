// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unmapped_folder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SonarrUnmappedFolder _$SonarrUnmappedFolderFromJson(
        Map<String, dynamic> json) =>
    SonarrUnmappedFolder(
      name: json['name'] as String?,
      path: json['path'] as String?,
    );

Map<String, dynamic> _$SonarrUnmappedFolderToJson(
    SonarrUnmappedFolder instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('path', instance.path);
  return val;
}
