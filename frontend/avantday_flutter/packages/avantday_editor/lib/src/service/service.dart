import 'package:avantday_editor/src/service/input_service.dart';
import 'package:avantday_editor/src/service/keyboard_service.dart';
import 'package:avantday_editor/src/service/render_plugin_service.dart';
import 'package:avantday_editor/src/service/scroll_service.dart';
import 'package:avantday_editor/src/service/selection_service.dart';
import 'package:avantday_editor/src/service/toolbar_service.dart';
import 'package:flutter/material.dart';

class FlowyService {
  // selection service
  final selectionServiceKey = GlobalKey(debugLabel: 'flowy_selection_service');
  AvantdaySelectionService get selectionService {
    assert(selectionServiceKey.currentState != null &&
        selectionServiceKey.currentState is AvantdaySelectionService);
    return selectionServiceKey.currentState! as AvantdaySelectionService;
  }

  // keyboard service
  final keyboardServiceKey = GlobalKey(debugLabel: 'flowy_keyboard_service');
  AvantdayKeyboardService? get keyboardService {
    if (keyboardServiceKey.currentState != null &&
        keyboardServiceKey.currentState is AvantdayKeyboardService) {
      return keyboardServiceKey.currentState! as AvantdayKeyboardService;
    }
    return null;
  }

  // input service
  final inputServiceKey = GlobalKey(debugLabel: 'flowy_input_service');
  AvantdayInputService? get inputService {
    if (inputServiceKey.currentState != null &&
        inputServiceKey.currentState is AvantdayInputService) {
      return inputServiceKey.currentState! as AvantdayInputService;
    }
    return null;
  }

  // render plugin service
  late AvantdayRenderPlugin renderPluginService;

  // toolbar service
  final toolbarServiceKey = GlobalKey(debugLabel: 'flowy_toolbar_service');
  AvantdayToolbarService? get toolbarService {
    if (toolbarServiceKey.currentState != null &&
        toolbarServiceKey.currentState is AvantdayToolbarService) {
      return toolbarServiceKey.currentState! as AvantdayToolbarService;
    }
    return null;
  }

  // scroll service
  final scrollServiceKey = GlobalKey(debugLabel: 'flowy_scroll_service');
  AvantdayScrollService? get scrollService {
    if (scrollServiceKey.currentState != null &&
        scrollServiceKey.currentState is AvantdayScrollService) {
      return scrollServiceKey.currentState! as AvantdayScrollService;
    }
    return null;
  }
}
