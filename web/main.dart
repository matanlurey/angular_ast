import 'dart:html';

import 'package:angular_ast/angular_ast.dart';
import 'package:source_span/source_span.dart';

import 'facade/code_mirror.dart';
import 'utils/outline.dart';

void main() {
  final code = new CodeMirror.fromTextArea(
    querySelector('#editor'),
    new CodeMirrorOptions(
      mode: 'htmlembedded',
      theme: 'material',
    ),
  );
  final errors = querySelector('#errors');
  final outline = querySelector('#outline');
  final humanize = const OutlineTemplateAstVisitor();
  code.focus();
  code.onChanges.listen((value) {
    try {
      errors.classes.add('none');
      outline.text = parse(value, sourceUrl: '/index.html')
          .map((a) => a.accept(humanize))
          .join('');
    } on FormatException catch (e) {
      final file = new SourceFile(value);
      errors.classes.remove('none');
      errors.text = file.location(e.offset).pointSpan().message(e.message);
    }
  });
}
