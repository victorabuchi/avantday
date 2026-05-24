import 'package:avantday_editor/avantday_editor.dart';
import 'package:avantday_editor/src/extensions/text_node_extensions.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../infra/test_editor.dart';

void main() async {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('markdown_syntax_to_styled_text_handler.dart', () {
    group('convert double asterisks to bold', () {
      Future<void> insertAsterisk(
        EditorWidgetTester editor, {
        int repeat = 1,
      }) async {
        for (var i = 0; i < repeat; i++) {
          await editor.pressLogicKey(
            LogicalKeyboardKey.asterisk,
            isShiftPressed: true,
          );
        }
      }

      testWidgets('**Avantday** to bold Avantday', (tester) async {
        const text = '**Avantday*';
        final editor = tester.editor..insertTextNode('');
        await editor.startTesting();
        await editor.updateSelection(
          Selection.single(path: [0], startOffset: 0),
        );
        final textNode = editor.nodeAtPath([0]) as TextNode;
        for (var i = 0; i < text.length; i++) {
          await editor.insertText(textNode, text[i], i);
        }
        await insertAsterisk(editor);
        final allBold = textNode.allSatisfyBoldInSelection(
          Selection.single(
            path: [0],
            startOffset: 0,
            endOffset: textNode.toPlainText().length,
          ),
        );
        expect(allBold, true);
        expect(textNode.toPlainText(), 'Avantday');
      });

      testWidgets('App**Flowy** to bold Avantday', (tester) async {
        const text = 'App**Flowy*';
        final editor = tester.editor..insertTextNode('');
        await editor.startTesting();
        await editor.updateSelection(
          Selection.single(path: [0], startOffset: 0),
        );
        final textNode = editor.nodeAtPath([0]) as TextNode;
        for (var i = 0; i < text.length; i++) {
          await editor.insertText(textNode, text[i], i);
        }
        await insertAsterisk(editor);
        final allBold = textNode.allSatisfyBoldInSelection(
          Selection.single(
            path: [0],
            startOffset: 3,
            endOffset: textNode.toPlainText().length,
          ),
        );
        expect(allBold, true);
        expect(textNode.toPlainText(), 'Avantday');
      });

      testWidgets('***Avantday** to bold *Avantday', (tester) async {
        const text = '***Avantday*';
        final editor = tester.editor..insertTextNode('');
        await editor.startTesting();
        await editor.updateSelection(
          Selection.single(path: [0], startOffset: 0),
        );
        final textNode = editor.nodeAtPath([0]) as TextNode;
        for (var i = 0; i < text.length; i++) {
          await editor.insertText(textNode, text[i], i);
        }
        await insertAsterisk(editor);
        final allBold = textNode.allSatisfyBoldInSelection(
          Selection.single(
            path: [0],
            startOffset: 1,
            endOffset: textNode.toPlainText().length,
          ),
        );
        expect(allBold, true);
        expect(textNode.toPlainText(), '*Avantday');
      });

      testWidgets('**Avantday** application to bold Avantday only',
          (tester) async {
        const boldText = '**Avantday*';
        final editor = tester.editor..insertTextNode('');
        await editor.startTesting();
        await editor.updateSelection(
          Selection.single(path: [0], startOffset: 0),
        );
        final textNode = editor.nodeAtPath([0]) as TextNode;

        for (var i = 0; i < boldText.length; i++) {
          await editor.insertText(textNode, boldText[i], i);
        }
        await insertAsterisk(editor);
        final boldTextLength = boldText.replaceAll('*', '').length;
        final appFlowyBold = textNode.allSatisfyBoldInSelection(
          Selection.single(
            path: [0],
            startOffset: 0,
            endOffset: boldTextLength,
          ),
        );
        expect(appFlowyBold, true);
        expect(textNode.toPlainText(), 'Avantday');
      });

      testWidgets('**** nothing changes', (tester) async {
        const text = '***';
        final editor = tester.editor..insertTextNode('');
        await editor.startTesting();
        await editor.updateSelection(
          Selection.single(path: [0], startOffset: 0),
        );
        final textNode = editor.nodeAtPath([0]) as TextNode;
        for (var i = 0; i < text.length; i++) {
          await editor.insertText(textNode, text[i], i);
        }
        await insertAsterisk(editor);
        final allBold = textNode.allSatisfyBoldInSelection(
          Selection.single(
            path: [0],
            startOffset: 0,
            endOffset: textNode.toPlainText().length,
          ),
        );
        expect(allBold, false);
        expect(textNode.toPlainText(), text);
      });
    });

    group('convert double underscores to bold', () {
      Future<void> insertUnderscore(
        EditorWidgetTester editor, {
        int repeat = 1,
      }) async {
        for (var i = 0; i < repeat; i++) {
          await editor.pressLogicKey(
            LogicalKeyboardKey.underscore,
            isShiftPressed: true,
          );
        }
      }

      testWidgets('__Avantday__ to bold Avantday', (tester) async {
        const text = '__Avantday_';
        final editor = tester.editor..insertTextNode('');
        await editor.startTesting();
        await editor.updateSelection(
          Selection.single(path: [0], startOffset: 0),
        );
        final textNode = editor.nodeAtPath([0]) as TextNode;
        for (var i = 0; i < text.length; i++) {
          await editor.insertText(textNode, text[i], i);
        }
        await insertUnderscore(editor);
        final allBold = textNode.allSatisfyBoldInSelection(
          Selection.single(
            path: [0],
            startOffset: 0,
            endOffset: textNode.toPlainText().length,
          ),
        );
        expect(allBold, true);
        expect(textNode.toPlainText(), 'Avantday');
      });

      testWidgets('App__Flowy__ to bold Avantday', (tester) async {
        const text = 'App__Flowy_';
        final editor = tester.editor..insertTextNode('');
        await editor.startTesting();
        await editor.updateSelection(
          Selection.single(path: [0], startOffset: 0),
        );
        final textNode = editor.nodeAtPath([0]) as TextNode;
        for (var i = 0; i < text.length; i++) {
          await editor.insertText(textNode, text[i], i);
        }
        await insertUnderscore(editor);
        final allBold = textNode.allSatisfyBoldInSelection(
          Selection.single(
            path: [0],
            startOffset: 3,
            endOffset: textNode.toPlainText().length,
          ),
        );
        expect(allBold, true);
        expect(textNode.toPlainText(), 'Avantday');
      });

      testWidgets('___Avantday__ to bold _Avantday', (tester) async {
        const text = '___Avantday_';
        final editor = tester.editor..insertTextNode('');
        await editor.startTesting();
        await editor.updateSelection(
          Selection.single(path: [0], startOffset: 0),
        );
        final textNode = editor.nodeAtPath([0]) as TextNode;
        for (var i = 0; i < text.length; i++) {
          await editor.insertText(textNode, text[i], i);
        }
        await insertUnderscore(editor);
        final allBold = textNode.allSatisfyBoldInSelection(
          Selection.single(
            path: [0],
            startOffset: 1,
            endOffset: textNode.toPlainText().length,
          ),
        );
        expect(allBold, true);
        expect(textNode.toPlainText(), '_Avantday');
      });

      testWidgets('__Avantday__ application to bold Avantday only',
          (tester) async {
        const boldText = '__Avantday_';
        final editor = tester.editor..insertTextNode('');
        await editor.startTesting();
        await editor.updateSelection(
          Selection.single(path: [0], startOffset: 0),
        );
        final textNode = editor.nodeAtPath([0]) as TextNode;

        for (var i = 0; i < boldText.length; i++) {
          await editor.insertText(textNode, boldText[i], i);
        }
        await insertUnderscore(editor);
        final boldTextLength = boldText.replaceAll('_', '').length;
        final appFlowyBold = textNode.allSatisfyBoldInSelection(
          Selection.single(
            path: [0],
            startOffset: 0,
            endOffset: boldTextLength,
          ),
        );
        expect(appFlowyBold, true);
        expect(textNode.toPlainText(), 'Avantday');
      });

      testWidgets('____ nothing changes', (tester) async {
        const text = '___';
        final editor = tester.editor..insertTextNode('');
        await editor.startTesting();
        await editor.updateSelection(
          Selection.single(path: [0], startOffset: 0),
        );
        final textNode = editor.nodeAtPath([0]) as TextNode;
        for (var i = 0; i < text.length; i++) {
          await editor.insertText(textNode, text[i], i);
        }
        await insertUnderscore(editor);
        final allBold = textNode.allSatisfyBoldInSelection(
          Selection.single(
            path: [0],
            startOffset: 0,
            endOffset: textNode.toPlainText().length,
          ),
        );
        expect(allBold, false);
        expect(textNode.toPlainText(), text);
      });
    });
  });
}
