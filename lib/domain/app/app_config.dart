import 'package:equatable/equatable.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:plugilo/core/utils/cast.dart';

class AppConfig extends Equatable {
  const AppConfig({
    required this.androidShowUpdate,
    required this.androidForceUpdate,
    required this.androidVersion,
    required this.iosShowUpdate,
    required this.iosForceUpdate,
    required this.iosVersion,
  });
  final String androidShowUpdate;
  final String androidForceUpdate;
  final String androidVersion;
  final String iosShowUpdate;
  final String iosForceUpdate;
  final String iosVersion;

  @override
  List<Object?> get props => [androidShowUpdate, androidForceUpdate, androidVersion, iosShowUpdate, iosForceUpdate, iosVersion];
  factory AppConfig.from(FirebaseRemoteConfig config) {
    return AppConfig(
      androidShowUpdate: config.getString('android_show_update'),
      androidForceUpdate: config.getString('android_force_update'),
      androidVersion: config.getString('android_version'),
      iosShowUpdate: config.getString('ios_show_update'),
      iosForceUpdate: config.getString('ios_force_update'),
      iosVersion: config.getString('ios_version'),
    );
  }

  factory AppConfig.fromJson(Map<String, dynamic> json) {
    return AppConfig(
      androidShowUpdate: safeCastString(json['androidShowUpdate']),
      androidForceUpdate: safeCastString(json['androidForceUpdate']),
      androidVersion: safeCastString(json['androidVersion']),
      iosShowUpdate: safeCastString(json['iosShowUpdate']),
      iosForceUpdate: safeCastString(json['iosForceUpdate']),
      iosVersion: safeCastString(json['iosVersion']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'androidShowUpdate': androidShowUpdate,
      'androidForceUpdate': androidForceUpdate,
      'androidVersion': androidVersion,
      'iosShowUpdate': iosShowUpdate,
      'iosForceUpdate': iosForceUpdate,
      'iosVersion': iosVersion,
    };
  }

  AppConfig copyWith({
    String? androidShowUpdate,
    String? androidForceUpdate,
    String? androidVersion,
    String? iosShowUpdate,
    String? iosForceUpdate,
    String? iosVersion,
  }) {
    return AppConfig(
      androidShowUpdate: androidShowUpdate ?? this.androidShowUpdate,
      androidForceUpdate: androidForceUpdate ?? this.androidForceUpdate,
      androidVersion: androidVersion ?? this.androidVersion,
      iosShowUpdate: iosShowUpdate ?? this.iosShowUpdate,
      iosForceUpdate: iosForceUpdate ?? this.iosForceUpdate,
      iosVersion: iosVersion ?? this.iosVersion,
    );
  }
}
