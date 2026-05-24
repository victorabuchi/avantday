import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'avantday_backend_platform_interface.dart';

/// An implementation of [AvantdayBackendPlatform] that uses method channels.
class MethodChannelFlowySdk extends AvantdayBackendPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('avantday_backend');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
