// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:angular_ast/angular_ast.dart';
import 'package:test/test.dart';

void main() => group('$NgToken', _testNgToken);

_testNgToken() {
  NgToken token;

  test('beforeElementDecorator', () {
    token = new NgToken.beforeElementDecorator(0, '\n  \n');
    expect(token.lexeme, '\n  \n');
    expect(token.end, 4);
    expect(token.length, 4);
    expect(token.offset, 0);
    expect(token.type, NgTokenType.beforeElementDecorator);
  });

  test('closeElementEnd', () {
    token = new NgToken.closeElementEnd(0);
    expect(token.lexeme, '>');
    expect(token.end, 1);
    expect(token.length, 1);
    expect(token.offset, 0);
    expect(token.type, NgTokenType.closeElementEnd);
  });

  test('closeElementStart', () {
    token = new NgToken.closeElementStart(0);
    expect(token.lexeme, '</');
    expect(token.end, 2);
    expect(token.length, 2);
    expect(token.offset, 0);
    expect(token.type, NgTokenType.closeElementStart);
  });

  test('elementDecorator', () {
    token = new NgToken.elementDecorator(0, 'title');
    expect(token.lexeme, 'title');
    expect(token.end, 5);
    expect(token.length, 5);
    expect(token.offset, 0);
    expect(token.type, NgTokenType.elementDecorator);
  });

  test('elementIdentifier', () {
    token = new NgToken.elementIdentifier(0, 'div');
    expect(token.lexeme, 'div');
    expect(token.end, 3);
    expect(token.length, 3);
    expect(token.offset, 0);
    expect(token.type, NgTokenType.elementIdentifier);
  });

  test('openElementEnd', () {
    token = new NgToken.openElementEnd(0);
    expect(token.lexeme, '>');
    expect(token.end, 1);
    expect(token.length, 1);
    expect(token.offset, 0);
    expect(token.type, NgTokenType.openElementEnd);
  });

  test('openElementStart', () {
    token = new NgToken.openElementStart(0);
    expect(token.lexeme, '<');
    expect(token.end, 1);
    expect(token.length, 1);
    expect(token.offset, 0);
    expect(token.type, NgTokenType.openElementStart);
  });

  test('text', () {
    token = new NgToken.text(0, 'Hello');
    expect(token.lexeme, 'Hello');
    expect(token.end, 5);
    expect(token.length, 5);
    expect(token.offset, 0);
    expect(token.type, NgTokenType.text);
  });
}
