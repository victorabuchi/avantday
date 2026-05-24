import 'package:avantday_editor/avantday_editor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  group('delta_markdown_encoder.dart', () {
    test('bold', () {
      final delta = Delta(operations: [
        TextInsert('Welcome to '),
        TextInsert('Avantday', attributes: {
          BuiltInAttributeKey.bold: true,
        }),
      ]);
      final result = DeltaMarkdownEncoder().convert(delta);
      expect(result, 'Welcome to **Avantday**');
    });

    test('italic', () {
      final delta = Delta(operations: [
        TextInsert('Welcome to '),
        TextInsert('Avantday', attributes: {
          BuiltInAttributeKey.italic: true,
        }),
      ]);
      final result = DeltaMarkdownEncoder().convert(delta);
      expect(result, 'Welcome to _Avantday_');
    });

    test('underline', () {
      final delta = Delta(operations: [
        TextInsert('Welcome to '),
        TextInsert('Avantday', attributes: {
          BuiltInAttributeKey.underline: true,
        }),
      ]);
      final result = DeltaMarkdownEncoder().convert(delta);
      expect(result, 'Welcome to <u>Avantday</u>');
    });

    test('strikethrough', () {
      final delta = Delta(operations: [
        TextInsert('Welcome to '),
        TextInsert('Avantday', attributes: {
          BuiltInAttributeKey.strikethrough: true,
        }),
      ]);
      final result = DeltaMarkdownEncoder().convert(delta);
      expect(result, 'Welcome to ~~Avantday~~');
    });

    test('href', () {
      final delta = Delta(operations: [
        TextInsert('Welcome to '),
        TextInsert('Avantday', attributes: {
          BuiltInAttributeKey.href: 'https://avantday.io',
        }),
      ]);
      final result = DeltaMarkdownEncoder().convert(delta);
      expect(result, 'Welcome to [Avantday](https://avantday.io)');
    });

    test('code', () {
      final delta = Delta(operations: [
        TextInsert('Welcome to '),
        TextInsert('Avantday', attributes: {
          BuiltInAttributeKey.code: true,
        }),
      ]);
      final result = DeltaMarkdownEncoder().convert(delta);
      expect(result, 'Welcome to `Avantday`');
    });

    test('composition', () {
      final delta = Delta(operations: [
        TextInsert('Welcome', attributes: {
          BuiltInAttributeKey.code: true,
          BuiltInAttributeKey.italic: true,
          BuiltInAttributeKey.bold: true,
          BuiltInAttributeKey.underline: true,
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
      final result = DeltaMarkdownEncoder().convert(delta);
      expect(
        result,
        '***<u>`Welcome`</u>*** ***~~to~~*** ***[Avantday](https://avantday.io)***',
      );
    });
  });
}
