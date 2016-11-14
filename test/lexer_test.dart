// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'package:angular_template_parser/src/lexer.dart';
import 'package:test/test.dart';

void main() {
  NgTemplateLexer lexer;

  test('should lex a simple text node', () async {
    lexer = new NgTemplateLexer('Hello World');
    expect(
      lexer.tokenize().toList(),
      [
        new NgToken(NgTokenType.textNode, 'Hello World'),
      ],
    );
  });

  test('should lex a simple text node and elements', () async {
    lexer = new NgTemplateLexer('<span>Hello World</span>');
    expect(
      lexer.tokenize().toList(),
      [
        new NgToken(NgTokenType.startOpenElement, '<'),
        new NgToken(NgTokenType.elementName, 'span'),
        new NgToken(NgTokenType.endOpenElement, '>'),
        new NgToken(NgTokenType.textNode, 'Hello World'),
        new NgToken(NgTokenType.startCloseElement, '</'),
        new NgToken(NgTokenType.elementName, 'span'),
        new NgToken(NgTokenType.endCloseElement, '>'),
      ],
    );
  });

  test('should lex a set of text and element nodes', () async {
    lexer = new NgTemplateLexer('<div>\n'
        '  <span>Hello<em>World</em>!</span>\n'
        '</div>');
    expect(
      lexer.tokenize().toList(),
      [
        new NgToken(NgTokenType.startOpenElement, '<'),
        new NgToken(NgTokenType.elementName, 'div'),
        new NgToken(NgTokenType.endOpenElement, '>'),
        new NgToken(NgTokenType.textNode, '\n  '),
        new NgToken(NgTokenType.startOpenElement, '<'),
        new NgToken(NgTokenType.elementName, 'span'),
        new NgToken(NgTokenType.endOpenElement, '>'),
        new NgToken(NgTokenType.textNode, 'Hello'),
        new NgToken(NgTokenType.startOpenElement, '<'),
        new NgToken(NgTokenType.elementName, 'em'),
        new NgToken(NgTokenType.endOpenElement, '>'),
        new NgToken(NgTokenType.textNode, 'World'),
        new NgToken(NgTokenType.startCloseElement, '</'),
        new NgToken(NgTokenType.elementName, 'em'),
        new NgToken(NgTokenType.endCloseElement, '>'),
        new NgToken(NgTokenType.textNode, '!'),
        new NgToken(NgTokenType.startCloseElement, '</'),
        new NgToken(NgTokenType.elementName, 'span'),
        new NgToken(NgTokenType.endCloseElement, '>'),
        new NgToken(NgTokenType.textNode, '\n'),
        new NgToken(NgTokenType.startCloseElement, '</'),
        new NgToken(NgTokenType.elementName, 'div'),
        new NgToken(NgTokenType.endCloseElement, '>'),
      ],
    );
  });

  test('should lex attributes with and without a value separate', () async {
    lexer = new NgTemplateLexer(
      '<div class="fancy" title="Hello"><button disabled></button></div>',
    );
    expect(lexer.tokenize().toList(), [
      new NgToken(NgTokenType.startOpenElement, '<'),
      new NgToken(NgTokenType.elementName, 'div'),
      new NgToken(NgTokenType.beforeElementDecorator, ' '),
      new NgToken(NgTokenType.attributeName, 'class'),
      new NgToken(NgTokenType.beforeDecoratorValue, '="'),
      new NgToken(NgTokenType.attributeValue, 'fancy'),
      new NgToken(NgTokenType.endAttribute, '"'),
      new NgToken(NgTokenType.beforeElementDecorator, ' '),
      new NgToken(NgTokenType.attributeName, 'title'),
      new NgToken(NgTokenType.beforeDecoratorValue, '="'),
      new NgToken(NgTokenType.attributeValue, 'Hello'),
      new NgToken(NgTokenType.endAttribute, '"'),
      new NgToken(NgTokenType.endOpenElement, '>'),
      new NgToken(NgTokenType.startOpenElement, '<'),
      new NgToken(NgTokenType.elementName, 'button'),
      new NgToken(NgTokenType.beforeElementDecorator, ' '),
      new NgToken(NgTokenType.attributeName, 'disabled'),
      new NgToken(NgTokenType.endAttribute, ''),
      new NgToken(NgTokenType.endOpenElement, '>'),
      new NgToken(NgTokenType.startCloseElement, '</'),
      new NgToken(NgTokenType.elementName, 'button'),
      new NgToken(NgTokenType.endCloseElement, '>'),
      new NgToken(NgTokenType.startCloseElement, '</'),
      new NgToken(NgTokenType.elementName, 'div'),
      new NgToken(NgTokenType.endCloseElement, '>'),
    ]);
  });

  test('should lex attributes with and without a value', () {
    lexer = new NgTemplateLexer(
      '<button disabled title="Hello"></button>',
    );
    expect(lexer.tokenize().toList(), [
      new NgToken(NgTokenType.startOpenElement, '<'),
      new NgToken(NgTokenType.elementName, 'button'),
      new NgToken(NgTokenType.beforeElementDecorator, ' '),
      new NgToken(NgTokenType.attributeName, 'disabled'),
      new NgToken(NgTokenType.endAttribute, ''),
      new NgToken(NgTokenType.beforeElementDecorator, ' '),
      new NgToken(NgTokenType.attributeName, 'title'),
      new NgToken(NgTokenType.beforeDecoratorValue, '="'),
      new NgToken(NgTokenType.attributeValue, 'Hello'),
      new NgToken(NgTokenType.endAttribute, '"'),
      new NgToken(NgTokenType.endOpenElement, '>'),
      new NgToken(NgTokenType.startCloseElement, '</'),
      new NgToken(NgTokenType.elementName, 'button'),
      new NgToken(NgTokenType.endCloseElement, '>'),
    ]);
  });

  test('should lex attributes with indenting whitespace', () async {
    lexer = new NgTemplateLexer('<div \n'
        '  title="Hello"\n'
        '  class="fancy">\n'
        '    Hello World\n'
        '</div>');
    expect(lexer.tokenize().toList(), [
      new NgToken(NgTokenType.startOpenElement, '<'),
      new NgToken(NgTokenType.elementName, 'div'),
      new NgToken(NgTokenType.beforeElementDecorator, ' \n  '),
      new NgToken(NgTokenType.attributeName, 'title'),
      new NgToken(NgTokenType.beforeDecoratorValue, '="'),
      new NgToken(NgTokenType.attributeValue, 'Hello'),
      new NgToken(NgTokenType.endAttribute, '"'),
      new NgToken(NgTokenType.beforeElementDecorator, '\n  '),
      new NgToken(NgTokenType.attributeName, 'class'),
      new NgToken(NgTokenType.beforeDecoratorValue, '="'),
      new NgToken(NgTokenType.attributeValue, 'fancy'),
      new NgToken(NgTokenType.endAttribute, '"'),
      new NgToken(NgTokenType.endOpenElement, '>'),
      new NgToken(NgTokenType.textNode, '\n    Hello World\n'),
      new NgToken(NgTokenType.startCloseElement, '</'),
      new NgToken(NgTokenType.elementName, 'div'),
      new NgToken(NgTokenType.endCloseElement, '>'),
    ]);
  });

  test('should lex properties', () async {
    lexer = new NgTemplateLexer('<button [title]="value"></button>');
    expect(lexer.tokenize().toList(), [
      new NgToken(NgTokenType.startOpenElement, '<'),
      new NgToken(NgTokenType.elementName, 'button'),
      new NgToken(NgTokenType.beforeElementDecorator, ' '),
      new NgToken(NgTokenType.startProperty, '['),
      new NgToken(NgTokenType.propertyName, 'title'),
      new NgToken(NgTokenType.beforeDecoratorValue, ']="'),
      new NgToken(NgTokenType.propertyValue, 'value'),
      new NgToken(NgTokenType.endProperty, '"'),
      new NgToken(NgTokenType.endOpenElement, '>'),
      new NgToken(NgTokenType.startCloseElement, '</'),
      new NgToken(NgTokenType.elementName, 'button'),
      new NgToken(NgTokenType.endCloseElement, '>'),
    ]);
  });

  test('should lex events', () {
    lexer = new NgTemplateLexer('<button (click)="onClick()"></button>');
    expect(lexer.tokenize().toList(), [
      new NgToken(NgTokenType.startOpenElement, '<'),
      new NgToken(NgTokenType.elementName, 'button'),
      new NgToken(NgTokenType.beforeElementDecorator, ' '),
      new NgToken(NgTokenType.startEvent, '('),
      new NgToken(NgTokenType.eventName, 'click'),
      new NgToken(NgTokenType.beforeDecoratorValue, ')="'),
      new NgToken(NgTokenType.eventValue, 'onClick()'),
      new NgToken(NgTokenType.endEvent, '"'),
      new NgToken(NgTokenType.endOpenElement, '>'),
      new NgToken(NgTokenType.startCloseElement, '</'),
      new NgToken(NgTokenType.elementName, 'button'),
      new NgToken(NgTokenType.endCloseElement, '>'),
    ]);
  });

  test('should lex properties and events', () {
    lexer = new NgTemplateLexer(
        '<button (click)="onClick()" [title]="name"></button>');
    expect(lexer.tokenize().toList(), [
      new NgToken(NgTokenType.startOpenElement, '<'),
      new NgToken(NgTokenType.elementName, 'button'),
      new NgToken(NgTokenType.beforeElementDecorator, ' '),
      new NgToken(NgTokenType.startEvent, '('),
      new NgToken(NgTokenType.eventName, 'click'),
      new NgToken(NgTokenType.beforeDecoratorValue, ')="'),
      new NgToken(NgTokenType.eventValue, 'onClick()'),
      new NgToken(NgTokenType.endEvent, '"'),
      new NgToken(NgTokenType.beforeElementDecorator, ' '),
      new NgToken(NgTokenType.startProperty, '['),
      new NgToken(NgTokenType.propertyName, 'title'),
      new NgToken(NgTokenType.beforeDecoratorValue, ']="'),
      new NgToken(NgTokenType.propertyValue, 'name'),
      new NgToken(NgTokenType.endProperty, '"'),
      new NgToken(NgTokenType.endOpenElement, '>'),
      new NgToken(NgTokenType.startCloseElement, '</'),
      new NgToken(NgTokenType.elementName, 'button'),
      new NgToken(NgTokenType.endCloseElement, '>'),
    ]);
  });

  test('should lex bindings', () {
    lexer = new NgTemplateLexer('<button #input></button>');
    expect(lexer.tokenize().toList(), [
      new NgToken(NgTokenType.startOpenElement, '<'),
      new NgToken(NgTokenType.elementName, 'button'),
      new NgToken(NgTokenType.beforeElementDecorator, ' '),
      new NgToken(NgTokenType.startBinding, '#'),
      new NgToken(NgTokenType.bindingName, 'input'),
      new NgToken(NgTokenType.endOpenElement, '>'),
      new NgToken(NgTokenType.startCloseElement, '</'),
      new NgToken(NgTokenType.elementName, 'button'),
      new NgToken(NgTokenType.endCloseElement, '>'),
    ]);
  });

  test('should lex bananas', () {
    lexer = new NgTemplateLexer('<button [(banana)]="someValue"></button>');
    expect(lexer.tokenize().toList(), [
      new NgToken(NgTokenType.startOpenElement, '<'),
      new NgToken(NgTokenType.elementName, 'button'),
      new NgToken(NgTokenType.beforeElementDecorator, ' '),
      new NgToken(NgTokenType.startBanana, '[('),
      new NgToken(NgTokenType.bananaName, 'banana'),
      new NgToken(NgTokenType.beforeDecoratorValue, ')]="'),
      new NgToken(NgTokenType.bananaValue, 'someValue'),
      new NgToken(NgTokenType.endBanana, '"'),
      new NgToken(NgTokenType.endOpenElement, '>'),
      new NgToken(NgTokenType.startCloseElement, '</'),
      new NgToken(NgTokenType.elementName, 'button'),
      new NgToken(NgTokenType.endCloseElement, '>'),
    ]);
  });

  test('should lex comments', () {
    lexer = new NgTemplateLexer('<h1>test <!-- This a comment --></h1>');
    expect(lexer.tokenize().toList(), [
      new NgToken(NgTokenType.startOpenElement, '<'),
      new NgToken(NgTokenType.elementName, 'h1'),
      new NgToken(NgTokenType.endOpenElement, '>'),
      new NgToken(NgTokenType.textNode, 'test '),
      new NgToken(NgTokenType.beginComment, '<!--'),
      new NgToken(NgTokenType.commentNode, ' This a comment '),
      new NgToken(NgTokenType.endComment, '-->'),
      new NgToken(NgTokenType.startCloseElement, '</'),
      new NgToken(NgTokenType.elementName, 'h1'),
      new NgToken(NgTokenType.endCloseElement, '>'),
    ]);
  });

  test('should lex structural directives', () {
    lexer = new NgTemplateLexer('<div *ngIf="bar"></div>');
    expect(lexer.tokenize().toList(), [
      new NgToken(NgTokenType.startOpenElement, '<'),
      new NgToken(NgTokenType.elementName, 'div'),
      new NgToken(NgTokenType.beforeElementDecorator, ' '),
      new NgToken(NgTokenType.startStructural, '*'),
      new NgToken(NgTokenType.structuralName, 'ngIf'),
      new NgToken(NgTokenType.beforeDecoratorValue, '="'),
      new NgToken(NgTokenType.structuralValue, 'bar'),
      new NgToken(NgTokenType.endStructural, '"'),
      new NgToken(NgTokenType.endOpenElement, '>'),
      new NgToken(NgTokenType.startCloseElement, '</'),
      new NgToken(NgTokenType.elementName, 'div'),
      new NgToken(NgTokenType.endCloseElement, '>')
    ]);
  });
  test('should lex just an interpolation', () {
    lexer = new NgTemplateLexer('{{value}}');
    expect(lexer.tokenize().toList(), [
      new NgToken(NgTokenType.startInterpolate, '{{'),
      new NgToken(NgTokenType.interpolation, 'value'),
      new NgToken(NgTokenType.endInterpolate, '}}'),
    ]);
  });

  test('should lex interpolated text', () {
    lexer = new NgTemplateLexer('Hello {{place}}!');
    expect(lexer.tokenize().toList(), [
      new NgToken(NgTokenType.textNode, 'Hello '),
      new NgToken(NgTokenType.startInterpolate, '{{'),
      new NgToken(NgTokenType.interpolation, 'place'),
      new NgToken(NgTokenType.endInterpolate, '}}'),
      new NgToken(NgTokenType.textNode, '!'),
    ]);
  });
}