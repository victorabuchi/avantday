import 'package:avantday_editor/avantday_editor.dart';
import 'package:avantday_editor/src/extensions/url_launcher_extension.dart';
import 'package:avantday_editor/src/flutter/overlay.dart';
import 'package:avantday_editor/src/infra/clipboard.dart';
import 'package:avantday_editor/src/infra/flowy_svg.dart';
import 'package:avantday_editor/src/render/color_menu/color_picker.dart';
import 'package:avantday_editor/src/render/link_menu/link_menu.dart';
import 'package:avantday_editor/src/extensions/text_node_extensions.dart';
import 'package:avantday_editor/src/extensions/editor_state_extensions.dart';
import 'package:avantday_editor/src/service/default_text_operations/format_rich_text_style.dart';

import 'package:flutter/material.dart' hide Overlay, OverlayEntry;

typedef ToolbarItemEventHandler = void Function(
    EditorState editorState, BuildContext context);
typedef ToolbarItemValidator = bool Function(EditorState editorState);
typedef ToolbarItemHighlightCallback = bool Function(EditorState editorState);

class ToolbarItem {
  ToolbarItem({
    required this.id,
    required this.type,
    this.tooltipsMessage = '',
    this.iconBuilder,
    required this.validator,
    this.highlightCallback,
    this.handler,
    this.itemBuilder,
  }) {
    assert(
      (iconBuilder != null && itemBuilder == null) ||
          (iconBuilder == null && itemBuilder != null),
      'iconBuilder and itemBuilder must be set one of them',
    );
  }

  final String id;
  final int type;
  final String tooltipsMessage;
  final ToolbarItemValidator validator;

  final Widget Function(bool isHighlight)? iconBuilder;
  final ToolbarItemEventHandler? handler;
  final ToolbarItemHighlightCallback? highlightCallback;

  final Widget Function(BuildContext context, EditorState editorState)?
      itemBuilder;

  factory ToolbarItem.divider() {
    return ToolbarItem(
      id: 'divider',
      type: -1,
      iconBuilder: (_) => const FlowySvg(name: 'toolbar/divider'),
      validator: (editorState) => true,
      handler: (editorState, context) {},
      highlightCallback: (editorState) => false,
    );
  }

  @override
  bool operator ==(Object other) {
    if (other is! ToolbarItem) {
      return false;
    }
    if (identical(this, other)) {
      return true;
    }
    return id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}

List<ToolbarItem> defaultToolbarItems = [
  ToolbarItem(
    id: 'avantday.toolbar.h1',
    type: 1,
    tooltipsMessage: AvantdayEditorLocalizations.current.heading1,
    iconBuilder: (isHighlight) => FlowySvg(
      name: 'toolbar/h1',
      color: isHighlight ? Colors.lightBlue : null,
    ),
    validator: _onlyShowInSingleTextSelection,
    highlightCallback: (editorState) => _allSatisfy(
      editorState,
      BuiltInAttributeKey.heading,
      (value) => value == BuiltInAttributeKey.h1,
    ),
    handler: (editorState, context) =>
        formatHeading(editorState, BuiltInAttributeKey.h1),
  ),
  ToolbarItem(
    id: 'avantday.toolbar.h2',
    type: 1,
    tooltipsMessage: AvantdayEditorLocalizations.current.heading2,
    iconBuilder: (isHighlight) => FlowySvg(
      name: 'toolbar/h2',
      color: isHighlight ? Colors.lightBlue : null,
    ),
    validator: _onlyShowInSingleTextSelection,
    highlightCallback: (editorState) => _allSatisfy(
      editorState,
      BuiltInAttributeKey.heading,
      (value) => value == BuiltInAttributeKey.h2,
    ),
    handler: (editorState, context) =>
        formatHeading(editorState, BuiltInAttributeKey.h2),
  ),
  ToolbarItem(
    id: 'avantday.toolbar.h3',
    type: 1,
    tooltipsMessage: AvantdayEditorLocalizations.current.heading3,
    iconBuilder: (isHighlight) => FlowySvg(
      name: 'toolbar/h3',
      color: isHighlight ? Colors.lightBlue : null,
    ),
    validator: _onlyShowInSingleTextSelection,
    highlightCallback: (editorState) => _allSatisfy(
      editorState,
      BuiltInAttributeKey.heading,
      (value) => value == BuiltInAttributeKey.h3,
    ),
    handler: (editorState, context) =>
        formatHeading(editorState, BuiltInAttributeKey.h3),
  ),
  ToolbarItem(
    id: 'avantday.toolbar.bold',
    type: 2,
    tooltipsMessage: AvantdayEditorLocalizations.current.bold,
    iconBuilder: (isHighlight) => FlowySvg(
      name: 'toolbar/bold',
      color: isHighlight ? Colors.lightBlue : null,
    ),
    validator: _showInBuiltInTextSelection,
    highlightCallback: (editorState) => _allSatisfy(
      editorState,
      BuiltInAttributeKey.bold,
      (value) => value == true,
    ),
    handler: (editorState, context) => formatBold(editorState),
  ),
  ToolbarItem(
    id: 'avantday.toolbar.italic',
    type: 2,
    tooltipsMessage: AvantdayEditorLocalizations.current.italic,
    iconBuilder: (isHighlight) => FlowySvg(
      name: 'toolbar/italic',
      color: isHighlight ? Colors.lightBlue : null,
    ),
    validator: _showInBuiltInTextSelection,
    highlightCallback: (editorState) => _allSatisfy(
      editorState,
      BuiltInAttributeKey.italic,
      (value) => value == true,
    ),
    handler: (editorState, context) => formatItalic(editorState),
  ),
  ToolbarItem(
    id: 'avantday.toolbar.underline',
    type: 2,
    tooltipsMessage: AvantdayEditorLocalizations.current.underline,
    iconBuilder: (isHighlight) => FlowySvg(
      name: 'toolbar/underline',
      color: isHighlight ? Colors.lightBlue : null,
    ),
    validator: _showInBuiltInTextSelection,
    highlightCallback: (editorState) => _allSatisfy(
      editorState,
      BuiltInAttributeKey.underline,
      (value) => value == true,
    ),
    handler: (editorState, context) => formatUnderline(editorState),
  ),
  ToolbarItem(
    id: 'avantday.toolbar.strikethrough',
    type: 2,
    tooltipsMessage: AvantdayEditorLocalizations.current.strikethrough,
    iconBuilder: (isHighlight) => FlowySvg(
      name: 'toolbar/strikethrough',
      color: isHighlight ? Colors.lightBlue : null,
    ),
    validator: _showInBuiltInTextSelection,
    highlightCallback: (editorState) => _allSatisfy(
      editorState,
      BuiltInAttributeKey.strikethrough,
      (value) => value == true,
    ),
    handler: (editorState, context) => formatStrikethrough(editorState),
  ),
  ToolbarItem(
    id: 'avantday.toolbar.code',
    type: 2,
    tooltipsMessage: AvantdayEditorLocalizations.current.embedCode,
    iconBuilder: (isHighlight) => FlowySvg(
      name: 'toolbar/code',
      color: isHighlight ? Colors.lightBlue : null,
    ),
    validator: _showInBuiltInTextSelection,
    highlightCallback: (editorState) => _allSatisfy(
      editorState,
      BuiltInAttributeKey.code,
      (value) => value == true,
    ),
    handler: (editorState, context) => formatEmbedCode(editorState),
  ),
  ToolbarItem(
    id: 'avantday.toolbar.quote',
    type: 3,
    tooltipsMessage: AvantdayEditorLocalizations.current.quote,
    iconBuilder: (isHighlight) => FlowySvg(
      name: 'toolbar/quote',
      color: isHighlight ? Colors.lightBlue : null,
    ),
    validator: _onlyShowInSingleTextSelection,
    highlightCallback: (editorState) => _allSatisfy(
      editorState,
      BuiltInAttributeKey.subtype,
      (value) => value == BuiltInAttributeKey.quote,
    ),
    handler: (editorState, context) {
      formatQuote(editorState);
    },
  ),
  ToolbarItem(
    id: 'avantday.toolbar.bulleted_list',
    type: 3,
    tooltipsMessage: AvantdayEditorLocalizations.current.bulletedList,
    iconBuilder: (isHighlight) => FlowySvg(
      name: 'toolbar/bulleted_list',
      color: isHighlight ? Colors.lightBlue : null,
    ),
    validator: _onlyShowInSingleTextSelection,
    highlightCallback: (editorState) => _allSatisfy(
      editorState,
      BuiltInAttributeKey.subtype,
      (value) => value == BuiltInAttributeKey.bulletedList,
    ),
    handler: (editorState, context) => formatBulletedList(editorState),
  ),
  ToolbarItem(
    id: 'avantday.toolbar.link',
    type: 4,
    tooltipsMessage: AvantdayEditorLocalizations.current.link,
    iconBuilder: (isHighlight) => FlowySvg(
      name: 'toolbar/link',
      color: isHighlight ? Colors.lightBlue : null,
    ),
    validator: _onlyShowInSingleTextSelection,
    highlightCallback: (editorState) => _allSatisfy(
      editorState,
      BuiltInAttributeKey.href,
      (value) => value != null,
    ),
    handler: (editorState, context) => showLinkMenu(context, editorState),
  ),
  ToolbarItem(
    id: 'avantday.toolbar.highlight',
    type: 4,
    tooltipsMessage: AvantdayEditorLocalizations.current.highlight,
    iconBuilder: (isHighlight) => FlowySvg(
      name: 'toolbar/highlight',
      color: isHighlight ? Colors.lightBlue : null,
    ),
    validator: _showInBuiltInTextSelection,
    highlightCallback: (editorState) => _allSatisfy(
      editorState,
      BuiltInAttributeKey.backgroundColor,
      (value) {
        return value != null && value != '0x00000000'; // transparent color;
      },
    ),
    handler: (editorState, context) => formatHighlight(
      editorState,
      editorState.editorStyle.highlightColorHex!,
    ),
  ),
  ToolbarItem(
    id: 'avantday.toolbar.color',
    type: 4,
    tooltipsMessage: AvantdayEditorLocalizations.current.color,
    iconBuilder: (isHighlight) => Icon(
      Icons.color_lens_outlined,
      size: 14,
      color: isHighlight ? Colors.lightBlue : Colors.white,
    ),
    validator: _showInBuiltInTextSelection,
    highlightCallback: (editorState) =>
        _allSatisfy(
          editorState,
          BuiltInAttributeKey.color,
          (value) =>
              value != null &&
              value != _generateFontColorOptions(editorState).first.colorHex,
        ) ||
        _allSatisfy(
          editorState,
          BuiltInAttributeKey.backgroundColor,
          (value) =>
              value != null &&
              value !=
                  _generateBackgroundColorOptions(editorState).first.colorHex,
        ),
    handler: (editorState, context) => showColorMenu(
      context,
      editorState,
    ),
  ),
];

ToolbarItemValidator _onlyShowInSingleTextSelection = (editorState) {
  final result = _showInBuiltInTextSelection(editorState);
  if (!result) {
    return false;
  }
  final nodes = editorState.service.selectionService.currentSelectedNodes;
  return (nodes.length == 1 && nodes.first is TextNode);
};

ToolbarItemValidator _showInBuiltInTextSelection = (editorState) {
  final nodes = editorState.service.selectionService.currentSelectedNodes
      .whereType<TextNode>()
      .where(
        (textNode) =>
            BuiltInAttributeKey.globalStyleKeys.contains(textNode.subtype) ||
            textNode.subtype == null,
      );
  return nodes.isNotEmpty;
};

bool _allSatisfy(
  EditorState editorState,
  String styleKey,
  bool Function(dynamic value) test,
) {
  final selection = editorState.service.selectionService.currentSelection.value;
  return selection != null &&
      editorState.selectedTextNodes.allSatisfyInSelection(
        selection,
        styleKey,
        test,
      );
}

OverlayEntry? _linkMenuOverlay;
OverlayEntry? _colorMenuOverlay;

EditorState? _editorState;
bool _changeSelectionInner = false;
void showLinkMenu(
  BuildContext context,
  EditorState editorState, {
  Selection? customSelection,
}) {
  final rects = editorState.service.selectionService.selectionRects;
  var maxBottom = 0.0;
  late Rect matchRect;
  for (final rect in rects) {
    if (rect.bottom > maxBottom) {
      maxBottom = rect.bottom;
      matchRect = rect;
    }
  }
  final baseOffset =
      editorState.renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;
  matchRect = matchRect.shift(-baseOffset);

  _dismissLinkMenu();
  _editorState = editorState;

  // Since the link menu will only show in single text selection,
  // We get the text node directly instead of judging details again.
  final selection = customSelection ??
      editorState.service.selectionService.currentSelection.value;
  final node = editorState.service.selectionService.currentSelectedNodes;
  if (selection == null || node.isEmpty || node.first is! TextNode) {
    return;
  }
  final index =
      selection.isBackward ? selection.start.offset : selection.end.offset;
  final length = (selection.start.offset - selection.end.offset).abs();
  final textNode = node.first as TextNode;
  String? linkText;
  if (textNode.allSatisfyLinkInSelection(selection)) {
    linkText = textNode.getAttributeInSelection<String>(
      selection,
      BuiltInAttributeKey.href,
    );
  }

  _linkMenuOverlay = OverlayEntry(builder: (context) {
    return Positioned(
      top: matchRect.bottom + 5.0,
      left: matchRect.left,
      child: Material(
        child: LinkMenu(
          linkText: linkText,
          editorState: editorState,
          onOpenLink: () async {
            await safeLaunchUrl(linkText);
          },
          onSubmitted: (text) async {
            await editorState.formatLinkInText(
              editorState,
              text,
              textNode: textNode,
            );

            _dismissLinkMenu();
          },
          onCopyLink: () {
            AvantdayClipboard.setData(text: linkText);
            _dismissLinkMenu();
          },
          onRemoveLink: () {
            final transaction = editorState.transaction
              ..formatText(
                textNode,
                index,
                length,
                {BuiltInAttributeKey.href: null},
              );
            editorState.apply(transaction);
            _dismissLinkMenu();
          },
          onFocusChange: (value) {
            if (value && customSelection != null) {
              _changeSelectionInner = true;
              editorState.service.selectionService
                  .updateSelection(customSelection);
            }
          },
        ),
      ),
    );
  });
  Overlay.of(context)?.insert(_linkMenuOverlay!);

  editorState.service.scrollService?.disable();
  editorState.service.keyboardService?.disable();
  editorState.service.selectionService.currentSelection
      .addListener(_dismissLinkMenu);
}

void _dismissLinkMenu() {
  // workaround: SelectionService has been released after hot reload.
  final isSelectionDisposed =
      _editorState?.service.selectionServiceKey.currentState == null;
  if (isSelectionDisposed) {
    return;
  }
  if (_editorState?.service.selectionService.currentSelection.value == null) {
    return;
  }
  if (_changeSelectionInner) {
    _changeSelectionInner = false;
    return;
  }
  _linkMenuOverlay?.remove();
  _linkMenuOverlay = null;

  _editorState?.service.scrollService?.enable();
  _editorState?.service.keyboardService?.enable();
  _editorState?.service.selectionService.currentSelection
      .removeListener(_dismissLinkMenu);
  _editorState = null;
}

void _dismissColorMenu() {
  // workaround: SelectionService has been released after hot reload.
  final isSelectionDisposed =
      _editorState?.service.selectionServiceKey.currentState == null;
  if (isSelectionDisposed) {
    return;
  }
  if (_editorState?.service.selectionService.currentSelection.value == null) {
    return;
  }
  if (_changeSelectionInner) {
    _changeSelectionInner = false;
    return;
  }
  _colorMenuOverlay?.remove();
  _colorMenuOverlay = null;

  _editorState?.service.scrollService?.enable();
  _editorState?.service.keyboardService?.enable();
  _editorState?.service.selectionService.currentSelection
      .removeListener(_dismissColorMenu);
  _editorState = null;
}

void showColorMenu(
  BuildContext context,
  EditorState editorState, {
  Selection? customSelection,
}) {
  final rects = editorState.service.selectionService.selectionRects;
  var maxBottom = 0.0;
  late Rect matchRect;
  for (final rect in rects) {
    if (rect.bottom > maxBottom) {
      maxBottom = rect.bottom;
      matchRect = rect;
    }
  }
  final baseOffset =
      editorState.renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;
  matchRect = matchRect.shift(-baseOffset);

  _dismissColorMenu();
  _editorState = editorState;

  // Since the link menu will only show in single text selection,
  // We get the text node directly instead of judging details again.
  final selection = customSelection ??
      editorState.service.selectionService.currentSelection.value;

  final node = editorState.service.selectionService.currentSelectedNodes;
  if (selection == null || node.isEmpty || node.first is! TextNode) {
    return;
  }
  final textNode = node.first as TextNode;

  String? backgroundColorHex;
  if (textNode.allSatisfyBackgroundColorInSelection(selection)) {
    backgroundColorHex = textNode.getAttributeInSelection<String>(
      selection,
      BuiltInAttributeKey.backgroundColor,
    );
  }
  String? fontColorHex;
  if (textNode.allSatisfyFontColorInSelection(selection)) {
    fontColorHex = textNode.getAttributeInSelection<String>(
      selection,
      BuiltInAttributeKey.color,
    );
  } else {
    fontColorHex = editorState.editorStyle.textStyle?.color?.toHex();
  }

  final style = editorState.editorStyle;
  _colorMenuOverlay = OverlayEntry(builder: (context) {
    return Positioned(
      top: matchRect.bottom + 5.0,
      left: matchRect.left + 10,
      child: Material(
        color: Colors.transparent,
        child: ColorPicker(
          pickerBackgroundColor:
              style.selectionMenuBackgroundColor ?? Colors.white,
          pickerItemHoverColor: style.selectionMenuItemSelectedColor ??
              Colors.blue.withOpacity(0.3),
          pickerItemTextColor: style.selectionMenuItemTextColor ?? Colors.black,
          selectedFontColorHex: fontColorHex,
          selectedBackgroundColorHex: backgroundColorHex,
          fontColorOptions: _generateFontColorOptions(editorState),
          backgroundColorOptions: _generateBackgroundColorOptions(editorState),
          onSubmittedbackgroundColorHex: (color) {
            formatHighlightColor(
              editorState,
              color,
            );
            _dismissColorMenu();
          },
          onSubmittedFontColorHex: (color) {
            formatFontColor(
              editorState,
              color,
            );
            _dismissColorMenu();
          },
        ),
      ),
    );
  });
  Overlay.of(context)?.insert(_colorMenuOverlay!);

  editorState.service.scrollService?.disable();
  editorState.service.keyboardService?.disable();
  editorState.service.selectionService.currentSelection
      .addListener(_dismissColorMenu);
}

List<ColorOption> _generateFontColorOptions(EditorState editorState) {
  final defaultColor =
      editorState.editorStyle.textStyle?.color ?? Colors.black; // black
  return [
    ColorOption(
      colorHex: defaultColor.toHex(),
      name: AvantdayEditorLocalizations.current.fontColorDefault,
    ),
    ColorOption(
      colorHex: Colors.grey.toHex(),
      name: AvantdayEditorLocalizations.current.fontColorGray,
    ),
    ColorOption(
      colorHex: Colors.brown.toHex(),
      name: AvantdayEditorLocalizations.current.fontColorBrown,
    ),
    ColorOption(
      colorHex: Colors.yellow.toHex(),
      name: AvantdayEditorLocalizations.current.fontColorYellow,
    ),
    ColorOption(
      colorHex: Colors.green.toHex(),
      name: AvantdayEditorLocalizations.current.fontColorGreen,
    ),
    ColorOption(
      colorHex: Colors.blue.toHex(),
      name: AvantdayEditorLocalizations.current.fontColorBlue,
    ),
    ColorOption(
      colorHex: Colors.purple.toHex(),
      name: AvantdayEditorLocalizations.current.fontColorPurple,
    ),
    ColorOption(
      colorHex: Colors.pink.toHex(),
      name: AvantdayEditorLocalizations.current.fontColorPink,
    ),
    ColorOption(
      colorHex: Colors.red.toHex(),
      name: AvantdayEditorLocalizations.current.fontColorRed,
    ),
  ];
}

List<ColorOption> _generateBackgroundColorOptions(EditorState editorState) {
  final defaultBackgroundColorHex =
      editorState.editorStyle.highlightColorHex ?? '0x6000BCF0';
  return [
    ColorOption(
      colorHex: defaultBackgroundColorHex,
      name: AvantdayEditorLocalizations.current.backgroundColorDefault,
    ),
    ColorOption(
      colorHex: Colors.grey.withOpacity(0.3).toHex(),
      name: AvantdayEditorLocalizations.current.backgroundColorGray,
    ),
    ColorOption(
      colorHex: Colors.brown.withOpacity(0.3).toHex(),
      name: AvantdayEditorLocalizations.current.backgroundColorBrown,
    ),
    ColorOption(
      colorHex: Colors.yellow.withOpacity(0.3).toHex(),
      name: AvantdayEditorLocalizations.current.backgroundColorYellow,
    ),
    ColorOption(
      colorHex: Colors.green.withOpacity(0.3).toHex(),
      name: AvantdayEditorLocalizations.current.backgroundColorGreen,
    ),
    ColorOption(
      colorHex: Colors.blue.withOpacity(0.3).toHex(),
      name: AvantdayEditorLocalizations.current.backgroundColorBlue,
    ),
    ColorOption(
      colorHex: Colors.purple.withOpacity(0.3).toHex(),
      name: AvantdayEditorLocalizations.current.backgroundColorPurple,
    ),
    ColorOption(
      colorHex: Colors.pink.withOpacity(0.3).toHex(),
      name: AvantdayEditorLocalizations.current.backgroundColorPink,
    ),
    ColorOption(
      colorHex: Colors.red.withOpacity(0.3).toHex(),
      name: AvantdayEditorLocalizations.current.backgroundColorRed,
    ),
  ];
}

extension on Color {
  String toHex() {
    return '0x${value.toRadixString(16)}';
  }
}
