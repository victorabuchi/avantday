import 'package:avantday/plugins/document/document.dart';
import 'package:avantday/startup/plugin/plugin.dart';
import 'package:avantday/startup/startup.dart';
import 'package:avantday/workspace/presentation/home/menu/app/header/import/import_panel.dart';
import 'package:avantday/workspace/presentation/widgets/pop_up_action.dart';
import 'package:avantday_editor/avantday_editor.dart' show Document;
import 'package:avantday_popover/avantday_popover.dart';
import 'package:flowy_infra/image.dart';
import 'package:flowy_infra_ui/style_widget/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:avantday/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class AddButton extends StatelessWidget {
  final Function(
    PluginBuilder,
    Document? document,
  ) onSelected;

  const AddButton({
    Key? key,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<PopoverAction> actions = [];

    // Plugins
    actions.addAll(
      pluginBuilders()
          .map((pluginBuilder) =>
              AddButtonActionWrapper(pluginBuilder: pluginBuilder))
          .toList(),
    );

    // Import
    actions.addAll(
      getIt<PluginSandbox>()
          .builders
          .whereType<DocumentPluginBuilder>()
          .map((pluginBuilder) =>
              ImportActionWrapper(pluginBuilder: pluginBuilder))
          .toList(),
    );

    return PopoverActionList<PopoverAction>(
      direction: PopoverDirection.bottomWithLeftAligned,
      actions: actions,
      buildChild: (controller) {
        return FlowyIconButton(
          width: 22,
          onPressed: () => controller.show(),
          icon: svgWidget(
            "home/add",
            color: Theme.of(context).colorScheme.onSurface,
          ).padding(horizontal: 3, vertical: 3),
        );
      },
      onSelected: (action, controller) {
        if (action is AddButtonActionWrapper) {
          onSelected(action.pluginBuilder, null);
        }
        if (action is ImportActionWrapper) {
          showImportPanel(context, (document) {
            if (document == null) {
              return;
            }
            onSelected(action.pluginBuilder, document);
          });
        }
        controller.close();
      },
    );
  }
}

class AddButtonActionWrapper extends ActionCell {
  final PluginBuilder pluginBuilder;

  AddButtonActionWrapper({required this.pluginBuilder});

  @override
  Widget? leftIcon(Color iconColor) =>
      svgWidget(pluginBuilder.menuIcon, color: iconColor);

  @override
  String get name => pluginBuilder.menuName;

  PluginType get pluginType => pluginBuilder.pluginType;
}

class ImportActionWrapper extends ActionCell {
  final DocumentPluginBuilder pluginBuilder;

  ImportActionWrapper({
    required this.pluginBuilder,
  });

  @override
  Widget? leftIcon(Color iconColor) => svgWidget(
        'editor/import',
        color: iconColor,
      );

  @override
  String get name => LocaleKeys.moreAction_import.tr();
}
