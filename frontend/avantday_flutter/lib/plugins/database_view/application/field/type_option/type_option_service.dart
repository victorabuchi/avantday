import 'package:dartz/dartz.dart';
import 'package:avantday_backend/dispatch/dispatch.dart';
import 'package:avantday_backend/protobuf/flowy-error/errors.pb.dart';
import 'package:avantday_backend/protobuf/flowy-database/cell_entities.pb.dart';
import 'package:avantday_backend/protobuf/flowy-database/select_type_option.pb.dart';

class TypeOptionBackendService {
  final String viewId;
  final String fieldId;

  TypeOptionBackendService({
    required this.viewId,
    required this.fieldId,
  });

  Future<Either<SelectOptionPB, FlowyError>> newOption({
    required String name,
  }) {
    final payload = CreateSelectOptionPayloadPB.create()
      ..optionName = name
      ..viewId = viewId
      ..fieldId = fieldId;

    return DatabaseEventCreateSelectOption(payload).send();
  }
}
