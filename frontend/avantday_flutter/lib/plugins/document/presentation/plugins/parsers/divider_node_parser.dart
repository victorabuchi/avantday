import 'package:avantday_editor/avantday_editor.dart';

class DividerNodeParser extends NodeParser {
  const DividerNodeParser();

  @override
  String get id => 'divider';

  @override
  String transform(Node node) {
    return '---\n';
  }
}
