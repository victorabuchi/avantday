import 'package:avantday/plugins/database_view/application/field/field_controller.dart';
import 'package:avantday_backend/protobuf/flowy-database/sort_entities.pb.dart';

class SortInfo {
  final SortPB sortPB;
  final FieldInfo fieldInfo;

  SortInfo({required this.sortPB, required this.fieldInfo});

  String get sortId => sortPB.id;
}
