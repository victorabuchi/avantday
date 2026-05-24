import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:avantday_backend/dispatch/dispatch.dart';
import 'package:avantday_backend/protobuf/flowy-error/errors.pb.dart';
import 'package:avantday_backend/protobuf/flowy-folder/app.pb.dart';

class HomeService {
  Future<Either<AppPB, FlowyError>> readApp({required String appId}) {
    final payload = AppIdPB.create()..value = appId;

    return FolderEventReadApp(payload).send();
  }
}
