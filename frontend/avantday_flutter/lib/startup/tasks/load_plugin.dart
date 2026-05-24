import 'package:avantday/plugins/database_view/calendar/calendar.dart';
import 'package:avantday/plugins/database_view/board/board.dart';
import 'package:avantday/plugins/database_view/grid/grid.dart';
import 'package:avantday/startup/plugin/plugin.dart';
import 'package:avantday/startup/startup.dart';
import 'package:avantday/plugins/blank/blank.dart';
import 'package:avantday/plugins/document/document.dart';
import 'package:avantday/plugins/trash/trash.dart';

class PluginLoadTask extends LaunchTask {
  @override
  LaunchTaskType get type => LaunchTaskType.dataProcessing;

  @override
  Future<void> initialize(LaunchContext context) async {
    registerPlugin(builder: BlankPluginBuilder(), config: BlankPluginConfig());
    registerPlugin(builder: TrashPluginBuilder(), config: TrashPluginConfig());
    registerPlugin(builder: DocumentPluginBuilder());
    registerPlugin(builder: GridPluginBuilder(), config: GridPluginConfig());
    registerPlugin(builder: BoardPluginBuilder(), config: BoardPluginConfig());
    registerPlugin(
        builder: CalendarPluginBuilder(), config: CalendarPluginConfig());
  }
}
