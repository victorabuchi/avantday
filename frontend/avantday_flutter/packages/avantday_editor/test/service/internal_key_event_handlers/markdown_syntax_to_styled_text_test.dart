import 'package:avantday_editor/avantday_editor.dart';
import 'package:avantday_editor/src/extensions/text_node_extensions.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../infra/test_editor.dart';

void main() async {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('markdown_syntax_to_styled_text.dart', () {
    group('convert single backquote to code', () {
      Future<void> insertBackquote(
        EditorWidgetTester editor, {
        int repeat = 1,
      }) async {
        for (var i = 0; i < repeat; i++) {
          await editor.pressLogicKey(
            LogicalKeyboardKey.backquote,
          );
        }
      }

      testWidgets('`Avantday` to code Avantday', (tester) async {
        const text = '`Avantday';
        final editor = tester.editor..insertTextNode('');
        await editor.startTesting();
        await editor.updateSelection(
          Selection.single(path: [0], startOffset: 0),
        );
        final textNode = editor.nodeAtPath([0]) as TextNode;
        for (var i = 0; i < text.length; i++) {
          await editor.insertText(textNode, text[i], i);
        }
        await insertBackquote(editor);
        final allCode = textNode.allSatisfyCodeInSelection(
          Selection.single(
            path: [0],
            startOffset: 0,
            endOffset: textNode.toPlainText().length,
          ),
        );
        expect(allCode, true);
        expect(textNode.toPlainText(), 'Avantday');
      });

      testWidgets('App`Flowy` to code Avantday', (tester) async {
        const text = 'App`Flowy';
        final editor = tester.editor..insertTextNode('');
        await editor.startTesting();
        await editor.updateSelection(
          Selection.single(path: [0], startOffset: 0),
        );
        final textNode = editor.nodeAtPath([0]) as TextNode;
        for (var i = 0; i < text.length; i++) {
          await editor.insertText(textNode, text[i], i);
        }
        await insertBackquote(editor);
        final allCode = textNode.allSatisfyCodeInSelection(
          Selection.single(
            path: [0],
            startOffset: 3,
            endOffset: textNode.toPlainText().length,
          ),
        );
        expect(allCode, true);
        expect(textNode.toPlainText(), 'Avantday');
      });

      testWidgets('`` nothing changes', (tester) async {
        const text = '`';
        final editor = tester.editor..insertTextNode('');
        await editor.startTesting();
        await editor.updateSelection(
          Selection.single(path: [0], startOffset: 0),
        );
        final textNode = editor.nodeAtPath([0]) as TextNode;
        for (var i = 0; i < text.length; i++) {
          await editor.insertText(textNode, text[i], i);
        }
        await insertBackquote(editor);
        final allCode = textNode.allSatisfyCodeInSelection(
          Selection.single(
            path: [0],
            startOffset: 0,
            endOffset: textNode.toPlainText().length,
          ),
        );
        expect(allCode, false);
        expect(textNode.toPlainText(), text);
      });
    });

    group('convert double backquote to code', () {
      Future<void> insertBackquote(
        EditorWidgetTester editor, {
        int repeat = 1,
      }) async {
        for (var i = 0; i < repeat; i++) {
          await editor.pressLogicKey(
            LogicalKeyboardKey.backquote,
          );
        }
      }

      testWidgets('```Avantday`` to code `Avantday', (tester) async {
        const text = '```Avantday`';
        final editor = tester.editor..insertTextNode('');
        await editor.startTesting();
        await editor.updateSelection(
          Selection.single(path: [0], startOffset: 0),
        );
        final textNode = editor.nodeAtPath([0]) as TextNode;
        for (var i = 0; i < text.length; i++) {
          await editor.insertText(textNode, text[i], i);
        }
        await insertBackquote(editor);
        final allCode = textNode.allSatisfyCodeInSelection(
          Selection.single(
            path: [0],
            startOffset: 1,
            endOffset: textNode.toPlainText().length,
          ),
        );
        expect(allCode, true);
        expect(textNode.toPlainText(), '`Avantday');
      });

      testWidgets('```` nothing changes', (tester) async {
        const text = '```';
        final editor = tester.editor..insertTextNode('');
        await editor.startTesting();
        await editor.updateSelection(
          Selection.single(path: [0], startOffset: 0),
        );
        final textNode = editor.nodeAtPath([0]) as TextNode;
        for (var i = 0; i < text.length; i++) {
          await editor.insertText(textNode, text[i], i);
        }
        await insertBackquote(editor);
        final allCode = textNode.allSatisfyCodeInSelection(
          Selection.single(
            path: [0],
            startOffset: 0,
            endOffset: textNode.toPlainText().length,
          ),
        );
        expect(allCode, false);
        expect(textNode.toPlainText(), text);
      });
    });

    group('convert double tilde to strikethrough', () {
      Future<void> insertTilde(
        EditorWidgetTester editor, {
        int repeat = 1,
      }) async {
        for (var i = 0; i < repeat; i++) {
          await editor.pressLogicKey(
            LogicalKeyboardKey.tilde,
            isShiftPressed: true,
          );
        }
      }

      testWidgets('~~Avantday~~ to strikethrough Avantday', (tester) async {
        const text = '~~Avantday~';
        final editor = tester.editor..insertTextNode('');
        await editor.startTesting();
        await editor.updateSelection(
          Selection.single(path: [0], startOffset: 0),
        );
        final textNode = editor.nodeAtPath([0]) as TextNode;
        for (var i = 0; i < text.length; i++) {
          await editor.insertText(textNode, text[i], i);
        }
        await insertTilde(editor);
        final allStrikethrough = textNode.allSatisfyStrikethroughInSelection(
          Selection.single(
            path: [0],
            startOffset: 0,
            endOffset: textNode.toPlainText().length,
          ),
        );
        expect(allStrikethrough, true);
        expect(textNode.toPlainText(), 'Avantday');
      });

      testWidgets('App~~Flowy~~ to strikethrough Avantday', (tester) async {
        const text = 'App~~Flowy~';
        final editor = tester.editor..insertTextNode('');
        await editor.startTesting();
        await editor.updateSelection(
          Selection.single(path: [0], startOffset: 0),
        );
        final textNode = editor.nodeAtPath([0]) as TextNode;
        for (var i = 0; i < text.length; i++) {
          await editor.insertText(textNode, text[i], i);
        }
        await insertTilde(editor);
        final allStrikethrough = textNode.allSatisfyStrikethroughInSelection(
          Selection.single(
            path: [0],
            startOffset: 3,
            endOffset: textNode.toPlainText().length,
          ),
        );
        expect(allStrikethrough, true);
        expect(textNode.toPlainText(), 'Avantday');
      });

      testWidgets('~~~Avantday~~ to bold ~Avantday', (tester) async {
        const text = '~~~Avantday~';
        final editor = tester.editor..insertTextNode('');
        await editor.startTesting();
        await editor.updateSelection(
          Selection.single(path: [0], startOffset: 0),
        );
        final textNode = editor.nodeAtPath([0]) as TextNode;
        for (var i = 0; i < text.length; i++) {
          await editor.insertText(textNode, text[i], i);
        }
        await insertTilde(editor);
        final allStrikethrough = textNode.allSatisfyStrikethroughInSelection(
          Selection.single(
            path: [0],
            startOffset: 1,
            endOffset: textNode.toPlainText().length,
          ),
        );
        expect(allStrikethrough, true);
        expect(textNode.toPlainText(), '~Avantday');
      });

      testWidgets('~~~~ nothing changes', (tester) async {
        const text = '~~~';
        final editor = tester.editor..insertTextNode('');
        await editor.startTesting();
        await editor.updateSelection(
          Selection.single(path: [0], startOffset: 0),
        );
        final textNode = editor.nodeAtPath([0]) as TextNode;
        for (var i = 0; i < text.length; i++) {
          await editor.insertText(textNode, text[i], i);
        }
        await insertTilde(editor);
        final allStrikethrough = textNode.allSatisfyStrikethroughInSelection(
          Selection.single(
            path: [0],
            startOffset: 0,
            endOffset: textNode.toPlainText().length,
          ),
        );
        expect(allStrikethrough, false);
        expect(textNode.toPlainText(), text);
      });
    });
  });
}
