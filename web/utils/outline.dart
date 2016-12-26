import 'package:angular_ast/angular_ast.dart';

class OutlineTemplateAstVisitor extends TemplateAstVisitor<String, int> {
  static String _indent(String text, int count) {
    return (' ' * (count ?? 0)) + text + '\n';
  }

  const OutlineTemplateAstVisitor();

  @override
  noSuchMethod(_) => '';

  @override
  String visitElement(ElementAst astNode, [int indent = 0]) {
    final buffer = new StringBuffer();
    buffer.write(_indent('#Element ${astNode.name}', indent));
    buffer.writeAll(astNode.childNodes.map(
      (n) => n.accept/*<String, int>*/(this, (indent ?? 0) + 2),
    ));
    return buffer.toString();
  }

  @override
  String visitText(TextAst astNode, [int indent = 0]) {
    return _indent('#Text ' + astNode.value.replaceAll('\n', '\\n'), indent);
  }
}
