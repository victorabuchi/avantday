import 'package:dartz/dartz.dart';
import 'package:avantday_backend/dispatch/dispatch.dart';
import 'package:avantday_backend/avantday_backend.dart';
import 'package:avantday_backend/protobuf/flowy-error/errors.pb.dart';
import 'package:avantday_backend/protobuf/flowy-user/user_profile.pb.dart';
import 'package:avantday_backend/protobuf/flowy-user/user_setting.pb.dart';

class UserSettingsBackendService {
  Future<AppearanceSettingsPB> getAppearanceSetting() async {
    final result = await UserEventGetAppearanceSetting().send();

    return result.fold(
      (AppearanceSettingsPB setting) {
        return setting;
      },
      (error) {
        throw FlowySDKException(ExceptionType.AppearanceSettingsIsEmpty);
      },
    );
  }

  Future<Either<UserSettingPB, FlowyError>> getUserSetting() {
    return UserEventGetUserSetting().send();
  }

  Future<Either<Unit, FlowyError>> setAppearanceSetting(
      AppearanceSettingsPB setting) {
    return UserEventSetAppearanceSetting(setting).send();
  }
}
