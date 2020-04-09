// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfileHiveObjectAdapter extends TypeAdapter<ProfileHiveObject> {
  @override
  final typeId = 0;

  @override
  ProfileHiveObject read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProfileHiveObject(
      lidarrEnabled: fields[0] as bool,
      lidarrHost: fields[1] as String,
      lidarrKey: fields[2] as String,
      lidarrStrictTLS: fields[18] as bool,
      radarrEnabled: fields[3] as bool,
      radarrHost: fields[4] as String,
      radarrKey: fields[5] as String,
      radarrStrictTLS: fields[17] as bool,
      sonarrEnabled: fields[6] as bool,
      sonarrHost: fields[7] as String,
      sonarrKey: fields[8] as String,
      sonarrStrictTLS: fields[16] as bool,
      sabnzbdEnabled: fields[9] as bool,
      sabnzbdHost: fields[10] as String,
      sabnzbdKey: fields[11] as String,
      sabnzbdStrictTLS: fields[19] as bool,
      nzbgetEnabled: fields[12] as bool,
      nzbgetHost: fields[13] as String,
      nzbgetUser: fields[14] as String,
      nzbgetPass: fields[15] as String,
      nzbgetStrictTLS: fields[20] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ProfileHiveObject obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(obj.lidarrEnabled)
      ..writeByte(1)
      ..write(obj.lidarrHost)
      ..writeByte(2)
      ..write(obj.lidarrKey)
      ..writeByte(18)
      ..write(obj.lidarrStrictTLS)
      ..writeByte(3)
      ..write(obj.radarrEnabled)
      ..writeByte(4)
      ..write(obj.radarrHost)
      ..writeByte(5)
      ..write(obj.radarrKey)
      ..writeByte(17)
      ..write(obj.radarrStrictTLS)
      ..writeByte(6)
      ..write(obj.sonarrEnabled)
      ..writeByte(7)
      ..write(obj.sonarrHost)
      ..writeByte(8)
      ..write(obj.sonarrKey)
      ..writeByte(16)
      ..write(obj.sonarrStrictTLS)
      ..writeByte(9)
      ..write(obj.sabnzbdEnabled)
      ..writeByte(10)
      ..write(obj.sabnzbdHost)
      ..writeByte(11)
      ..write(obj.sabnzbdKey)
      ..writeByte(19)
      ..write(obj.sabnzbdStrictTLS)
      ..writeByte(12)
      ..write(obj.nzbgetEnabled)
      ..writeByte(13)
      ..write(obj.nzbgetHost)
      ..writeByte(14)
      ..write(obj.nzbgetUser)
      ..writeByte(15)
      ..write(obj.nzbgetPass)
      ..writeByte(20)
      ..write(obj.nzbgetStrictTLS);
  }
}
