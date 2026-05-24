import 'package:avantday_editor/src/core/document/node.dart';

abstract class NodeParser {
  const NodeParser();

  String get id;
  String transform(Node node);
}
