import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'avantday_backend_method_channel.dart';

abstract class AvantdayBackendPlatform extends PlatformInterface {
  /// Constructs a FlowySdkPlatform.
  AvantdayBackendPlatform() : super(token: _token);

  static final Object _token = Object();

  static AvantdayBackendPlatform _instance = MethodChannelFlowySdk();

  /// The default instance of [AvantdayBackendPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlowySdk].
  static AvantdayBackendPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AvantdayBackendPlatform] when
  /// they register themselves.
  static set instance(AvantdayBackendPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
