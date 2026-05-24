<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

<h1 align="center"><b>Avantday Editor</b></h1>

<p align="center">A highly customizable rich-text editor for Flutter</p>

<p align="center">
    <a href="https://discord.gg/ZCCYN4Anzq"><b>Discord</b></a> •
    <a href="https://twitter.com/avantday"><b>Twitter</b></a>
</p>

<p align="center">
    <a href="https://codecov.io/gh/Avantday-IO/Avantday" >
        <img src="https://codecov.io/gh/Avantday-IO/Avantday/branch/main/graph/badge.svg?token=YTFKUF70B6"/>
    </a>
</p>

<div align="center">
    <img src="https://github.com/Avantday-IO/Avantday/blob/main/frontend/avantday_flutter/packages/avantday_editor/documentation/images/avantday_editor_example.mp4?raw=true" width = "700" style = "padding: 100"/>
</div>

## Key Features

* Build rich, intuitive editors
* Design and modify an ever expanding list of customizable features including
  * components (such as form input controls, numbered lists, and rich text widgets)
  * shortcut events
  * themes
  * menu options (**coming soon!**)
* [Test-coverage](https://github.com/Avantday-IO/Avantday/blob/main/frontend/avantday_flutter/packages/avantday_editor/documentation/testing.md) and ongoing maintenance by Avantday's core team and community of more than 1,000 builders

## Getting Started

Add the Avantday editor [Flutter package](https://docs.flutter.dev/development/packages-and-plugins/using-packages) to your environment.

```shell
flutter pub add avantday_editor
flutter pub get
```

## Creating Your First Editor

Start by creating a new empty AvantdayEditor object.

```dart
final editorState = EditorState.empty(); // an empty state
final editor = AvantdayEditor(
    editorState: editorState,
);
```

You can also create an editor from a JSON object in order to configure your initial state. Or you can [create an editor from Markdown or Quill Delta](https://github.com/Avantday-IO/Avantday/blob/main/frontend/avantday_flutter/packages/avantday_editor/documentation/importing.md).

```dart
final json = ...;
final editorState = EditorState(Document.fromJson(data));
final editor = AvantdayEditor(
    editorState: editorState,
);
```

> Note: The parameters `localizationsDelegates` need to be assigned in MaterialApp widget
```dart
MaterialApp(
    localizationsDelegates: const [
        AvantdayEditorLocalizations.delegate,
    ]，
);
```

To get a sense of how the Avantday Editor works, run our example:

```shell
git clone https://github.com/Avantday-IO/Avantday.git
cd frontend/avantday_flutter/packages/avantday_editor/example
flutter run
```

## Customizing Your Editor

### Customizing Components

Please refer to our documentation on customizing Avantday for a detailed discussion about [customizing components](https://github.com/Avantday-IO/Avantday/blob/main/frontend/avantday_flutter/packages/avantday_editor/documentation/customizing.md#customize-a-component).

Below are some examples of component customizations:

 * [Checkbox Text](https://github.com/Avantday-IO/Avantday/blob/main/frontend/avantday_flutter/packages/avantday_editor/lib/src/render/rich_text/checkbox_text.dart) demonstrates how to extend new styles based on existing rich text components
 * [Image](https://github.com/Avantday-IO/Avantday/blob/main/frontend/avantday_flutter/packages/avantday_editor/example/lib/plugin/network_image_node_widget.dart) demonstrates how to extend a new node and render it
 * See further examples of [rich-text plugins](https://github.com/Avantday-IO/Avantday/blob/main/frontend/avantday_flutter/packages/avantday_editor/lib/src/render/rich_text)

### Customizing Shortcut Events

Please refer to our documentation on customizing Avantday for a detailed discussion about [customizing shortcut events](https://github.com/Avantday-IO/Avantday/blob/main/frontend/avantday_flutter/packages/avantday_editor/documentation/customizing.md#customize-a-shortcut-event).

Below are some examples of shortcut event customizations:

 * [BIUS](https://github.com/Avantday-IO/Avantday/blob/main/frontend/avantday_flutter/packages/avantday_editor/lib/src/service/internal_key_event_handlers/format_style_handler.dart) demonstrates how to make text bold/italic/underline/strikethrough through shortcut keys
 * [Paste HTML](https://github.com/Avantday-IO/Avantday/blob/main/frontend/avantday_flutter/packages/avantday_editor/lib/src/service/internal_key_event_handlers/copy_paste_handler.dart) gives you an idea on how to handle pasted styles through shortcut keys
 * Need more examples? Check out [Internal key event handlers](https://github.com/Avantday-IO/Avantday/blob/main/frontend/avantday_flutter/packages/avantday_editor/lib/src/service/internal_key_event_handlers)

## Glossary
Please refer to the API documentation.

## Contributing
Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are greatly appreciated.

Please look at [CONTRIBUTING.md](https://avantday.gitbook.io/docs/essential-documentation/contribute-to-avantday/contributing-to-avantday) for details.

## License
Distributed under the AGPLv3 License. See [LICENSE](https://github.com/Avantday-IO/Avantday-Docs/blob/main/LICENSE) for more information.
