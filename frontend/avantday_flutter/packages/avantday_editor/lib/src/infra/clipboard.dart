import 'dart:io' show Platform;

import 'package:rich_clipboard/rich_clipboard.dart';

class AvantdayClipboardData {
  const AvantdayClipboardData({
    required this.text,
    required this.html,
  });
  final String? text;
  final String? html;
}

class AvantdayClipboard {
  static Future<void> setData({
    String? text,
    String? html,
  }) async {
    // https://github.com/BringingFire/rich_clipboard/issues/13
    // Wrapping a `<html><body>` tag for html in Windows,
    //  otherwise it will raise an exception
    if (Platform.isWindows && html != null) {
      if (!html.startsWith('<html><body>')) {
        html = '<html><body>$html</body></html>';
      }
    }

    return RichClipboard.setData(
      RichClipboardData(
        text: text,
        html: html,
      ),
    );
  }

  static Future<AvantdayClipboardData> getData() async {
    final data = await RichClipboard.getData();
    final text = data.text;
    var html = data.html;

    // https://github.com/BringingFire/rich_clipboard/issues/13
    // Remove all the fragment symbol in Windows.
    if (Platform.isWindows && html != null) {
      html = html
          .replaceAll('<!--StartFragment-->', '')
          .replaceAll('<!--EndFragment-->', '');
    }

    return AvantdayClipboardData(
      text: text,
      html: html,
    );
  }
}
