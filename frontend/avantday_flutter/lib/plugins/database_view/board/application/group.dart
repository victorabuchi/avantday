import 'package:avantday_backend/protobuf/flowy-database/field_entities.pb.dart';

class BoardGroupService {
  final String viewId;
  FieldPB? groupField;

  BoardGroupService(this.viewId);

  void setGroupField(FieldPB field) {
    groupField = field;
  }
}
