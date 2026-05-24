import 'package:avantday/startup/launch_configuration.dart';
import 'package:avantday/startup/startup.dart';
import 'package:avantday/user/application/auth_service.dart';
import 'package:avantday/user/application/user_service.dart';
import 'package:avantday/workspace/application/workspace/workspace_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flowy_infra/uuid.dart';
import 'package:avantday_backend/protobuf/flowy-folder/app.pb.dart';
import 'package:avantday_backend/protobuf/flowy-folder/workspace.pb.dart';
import 'package:avantday_backend/protobuf/flowy-user/protobuf.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:avantday/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AvantdayIntegrateTest {
  static Future<AvantdayIntegrateTest> ensureInitialized() async {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    main();
    return AvantdayIntegrateTest();
  }
}

class AvantdayUnitTest {
  late UserProfilePB userProfile;
  late UserBackendService userService;
  late WorkspaceService workspaceService;
  late List<WorkspacePB> workspaces;

  static Future<AvantdayUnitTest> ensureInitialized() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    _pathProviderInitialized();

    await EasyLocalization.ensureInitialized();
    await FlowyRunner.run(FlowyTestApp());

    final test = AvantdayUnitTest();
    await test._signIn();
    await test._loadWorkspace();

    await test._initialServices();
    return test;
  }

  Future<void> _signIn() async {
    final authService = getIt<AuthService>();
    const password = "Avantday123@";
    final uid = uuid();
    final userEmail = "$uid@avantday.io";
    final result = await authService.signUp(
      name: "TestUser",
      password: password,
      email: userEmail,
    );
    return result.fold(
      (user) {
        userProfile = user;
        userService = UserBackendService(userId: userProfile.id);
      },
      (error) {},
    );
  }

  WorkspacePB get currentWorkspace => workspaces[0];

  Future<void> _loadWorkspace() async {
    final result = await userService.getWorkspaces();
    result.fold(
      (value) => workspaces = value,
      (error) {
        throw Exception(error);
      },
    );
  }

  Future<void> _initialServices() async {
    workspaceService = WorkspaceService(workspaceId: currentWorkspace.id);
  }

  Future<AppPB> createTestApp() async {
    final result = await workspaceService.createApp(name: "Test App");
    return result.fold(
      (app) => app,
      (error) => throw Exception(error),
    );
  }

  Future<List<AppPB>> loadApps() async {
    final result = await workspaceService.getApps();

    return result.fold(
      (apps) => apps,
      (error) => throw Exception(error),
    );
  }
}

void _pathProviderInitialized() {
  const MethodChannel channel =
      MethodChannel('plugins.flutter.io/path_provider');
  channel.setMockMethodCallHandler((MethodCall methodCall) async {
    return ".";
  });
}

class FlowyTestApp implements EntryPoint {
  @override
  Widget create(LaunchConfiguration config) {
    return Container();
  }
}

Future<void> blocResponseFuture({int millisecond = 200}) {
  return Future.delayed(Duration(milliseconds: millisecond));
}

Duration blocResponseDuration({int milliseconds = 200}) {
  return Duration(milliseconds: milliseconds);
}
