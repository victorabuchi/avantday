import 'package:avantday_editor/src/editor_state.dart';
import 'package:flutter/material.dart';

typedef ShortcutEventHandler = KeyEventResult Function(
  EditorState editorState,
  RawKeyEvent? event,
);
