@JS()
library angular_ast.src.web.js_facade;

import 'dart:async';
import 'dart:html';

import 'dart:js';
import 'package:js/js.dart';

@JS('CodeMirror')
abstract class _JsCodeMirror implements JsObject {
  external static _JsCodeMirror fromTextArea(
    TextAreaElement element, [
    CodeMirrorOptions options,
  ]);

  external void focus();
  external String getValue();
}

class CodeMirror {
  static const _pollInterval = const Duration(milliseconds: 100);

  final _JsCodeMirror _jsObject;

  factory CodeMirror.fromTextArea(
    TextAreaElement element, [
    CodeMirrorOptions options,
  ]) {
    return new CodeMirror._(_JsCodeMirror.fromTextArea(element, options));
  }

  CodeMirror._(this._jsObject);

  void focus() {
    _jsObject.focus();
  }

  Stream get onChanges {
    // TODO: Replace with actual on('changes', ...) - throws in dart2js :-/
    return new Stream.periodic(_pollInterval, (_) => value).distinct();
  }

  String get value => _jsObject.getValue();
}

@JS()
@anonymous
abstract class CodeMirrorOptions {
  external factory CodeMirrorOptions({String mode, String theme});
}
