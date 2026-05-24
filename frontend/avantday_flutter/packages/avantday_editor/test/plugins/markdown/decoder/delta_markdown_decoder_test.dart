import 'package:avantday_editor/avantday_editor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  group('delta_markdown_decoder.dart', () {
    test('bold', () {
      final delta = Delta(operations: [
        TextInsert('Welcome to '),
        TextInsert('Avantday', attributes: {
          BuiltInAttributeKey.bold: true,
        }),
      ]);
      final result = DeltaMarkdownDecoder().convert('Welcome to **Avantday**');
      expect(result, delta);
    });

    test('italic', () {
      final delta = Delta(operations: [
        TextInsert('Welcome to '),
        TextInsert('Avantday', attributes: {
          BuiltInAttributeKey.italic: true,
        }),
      ]);
      final result = DeltaMarkdownDecoder().convert('Welcome to _Avantday_');
      expect(result, delta);
    });

    test('strikethrough', () {
      final delta = Delta(operations: [
        TextInsert('Welcome to '),
        TextInsert('Avantday', attributes: {
          BuiltInAttributeKey.strikethrough: true,
        }),
      ]);
      final result = DeltaMarkdownDecoder().convert('Welcome to ~~Avantday~~');
      expect(result, delta);
    });

    test('href', () {
      final delta = Delta(operations: [
        TextInsert('Welcome to '),
        TextInsert('Avantday', attributes: {
          BuiltInAttributeKey.href: 'https://avantday.io',
        }),
      ]);
      final result = DeltaMarkdownDecoder()
          .convert('Welcome to [Avantday](https://avantday.io)');
      expect(result, delta);
    });

    test('code', () {
      final delta = Delta(operations: [
        TextInsert('Welcome to '),
        TextInsert('Avantday', attributes: {
          BuiltInAttributeKey.code: true,
        }),
      ]);
      final result = DeltaMarkdownDecoder().convert('Welcome to `Avantday`');
      expect(result, delta);
    });

    test('bold', () {
      const markdown =
          '***<u>`Welcome`</u>*** ***~~to~~*** ***[Avantday](https://avantday.io)***';
      final delta = Delta(operations: [
        TextInsert('<u>', attributes: {
          BuiltInAttributeKey.italic: true,
          BuiltInAttributeKey.bold: true,
        }),
        TextInsert('Welcome', attributes: {
          BuiltInAttributeKey.code: true,
          BuiltInAttributeKey.italic: true,
          BuiltInAttributeKey.bold: true,
        }),
        TextInsert('</u>', attributes: {
          BuiltInAttributeKey.italic: true,
          BuiltInAttributeKey.bold: true,
        }),
        TextInsert(' '),
        TextInsert('to', attributes: {
          BuiltInAttributeKey.italic: true,
          BuiltInAttributeKey.bold: true,
          BuiltInAttributeKey.strikethrough: true,
        }),
        TextInsert(' '),
        TextInsert('Avantday', attributes: {
          BuiltInAttributeKey.href: 'https://avantday.io',
          BuiltInAttributeKey.bold: true,
          BuiltInAttributeKey.italic: true,
        }),
      ]);
      final result = DeltaMarkdownDecoder().convert(markdown);
      expect(result, delta);
    });
  });
}
