// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
part of angular2_template_parser.src.compiler_error;

/// When an [NgTokenType.interpolation], [NgTokenType.eventValue],
/// [NgTokenType.propertyValue] contains a Dart expression which is rejected
/// by the analyzer.
class InvalidDartExpressionError extends SourceError {
  /// The parsed [NgToken] representing the element name.
  final NgToken elementToken;

  /// The original error from the analyzer.
  final AnalyzerErrorGroup analysisError;

  factory InvalidDartExpressionError(
      NgToken elementToken, AnalyzerErrorGroup analysisError) {
    return new InvalidDartExpressionError._(
        elementToken, analysisError, elementToken.source);
  }

  InvalidDartExpressionError._(
      this.elementToken, this.analysisError, SourceSpan context)
      : super._(context);

  @override
  String toString() => toFriendlyMessage(header: analysisError.message);
}