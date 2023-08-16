enum TokenType {
  // Single-character tokens.
  leftParen, rightParen, leftBrace, rightBrace,
  comma, dot, minus, plus, semicolon, slash, star, question, colon,

  // One or two character tokens.
  bang, bangEqual,
  equal, equalEqual,
  greater, greaterEqual,
  less, lessEqual,
  plusPlus, minusMinus,

  // Literals.
  identifier, string, number,

  // Keywords.
  keywordAnd, keywordClass, keywordElse, keywordFalse, keywordFun, keywordFor,
  keywordIf, keywordNil, keywordOr,
  keywordPrint, keywordReturn, keywordSuper, keywordThis, keywordTrue,
  keywordVar, keywordWhile, keywordBreak, keywordContinue,

  eof
}
