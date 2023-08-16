import 'package:dlox/scanner.dart';
import 'package:dlox/token_type.dart';
import 'package:test/test.dart';

void main() {
  test('scans the left paren', () {
    final tokens = Scanner('(').scanTokens();
    expect(tokens, hasLength(2));
    expect(tokens[0].type, equals(TokenType.leftParen));
    expect(tokens[1].type, equals(TokenType.eof));
  });

  test('token line is identified correctly for a single character token', () {
    final tokens = Scanner('(').scanTokens();
    expect(tokens[0].line, equals(1));
  });

  test('token column is identified correctly for a single character token', () {
    final tokens = Scanner('(').scanTokens();
    expect(tokens[0].column, equals(1));
  });

  test('scans the right paren', () {
    final tokens = Scanner(')').scanTokens();
    expect(tokens, hasLength(2));
    expect(tokens[0].type, equals(TokenType.rightParen));
    expect(tokens[1].type, equals(TokenType.eof));
  });

  test('scans the left brace', () {
    final tokens = Scanner('{').scanTokens();
    expect(tokens, hasLength(2));
    expect(tokens[0].type, equals(TokenType.leftBrace));
    expect(tokens[1].type, equals(TokenType.eof));
  });

  test('scans the right brace', () {
    final tokens = Scanner('}').scanTokens();
    expect(tokens, hasLength(2));
    expect(tokens[0].type, equals(TokenType.rightBrace));
    expect(tokens[1].type, equals(TokenType.eof));
  });

  test('scans the comma', () {
    final tokens = Scanner(',').scanTokens();
    expect(tokens, hasLength(2));
    expect(tokens[0].type, equals(TokenType.comma));
    expect(tokens[1].type, equals(TokenType.eof));
  });

  test('scans the dot', () {
    final tokens = Scanner('.').scanTokens();
    expect(tokens, hasLength(2));
    expect(tokens[0].type, equals(TokenType.dot));
    expect(tokens[1].type, equals(TokenType.eof));
  });

  test('scans the minus', () {
    final tokens = Scanner('-').scanTokens();
    expect(tokens, hasLength(2));
    expect(tokens[0].type, equals(TokenType.minus));
    expect(tokens[1].type, equals(TokenType.eof));
  });

  test('scans the plus', () {
    final tokens = Scanner('+').scanTokens();
    expect(tokens, hasLength(2));
    expect(tokens[0].type, equals(TokenType.plus));
    expect(tokens[1].type, equals(TokenType.eof));
  });

  test('scans the semicolon', () {
    final tokens = Scanner(';').scanTokens();
    expect(tokens, hasLength(2));
    expect(tokens[0].type, equals(TokenType.semicolon));
    expect(tokens[1].type, equals(TokenType.eof));
  });

  test('scans the star', () {
    final tokens = Scanner('*').scanTokens();
    expect(tokens, hasLength(2));
    expect(tokens[0].type, equals(TokenType.star));
    expect(tokens[1].type, equals(TokenType.eof));
  });

  test('scans the bang', () {
    final tokens = Scanner('!').scanTokens();
    expect(tokens, hasLength(2));
    expect(tokens[0].type, equals(TokenType.bang));
    expect(tokens[1].type, equals(TokenType.eof));
  });

  test('scans the bang equal', () {
    final tokens = Scanner('!=').scanTokens();
    expect(tokens, hasLength(2));
    expect(tokens[0].type, equals(TokenType.bangEqual));
    expect(tokens[1].type, equals(TokenType.eof));
  });

  test('token column is identified correctly for a two character token', () {
    final tokens = Scanner('!=').scanTokens();
    expect(tokens[0].column, equals(1));
  });

  test('scans the equal', () {
    final tokens = Scanner('=').scanTokens();
    expect(tokens, hasLength(2));
    expect(tokens[0].type, equals(TokenType.equal));
    expect(tokens[1].type, equals(TokenType.eof));
  });

  test('scans the equal equal', () {
    final tokens = Scanner('==').scanTokens();
    expect(tokens, hasLength(2));
    expect(tokens[0].type, equals(TokenType.equalEqual));
    expect(tokens[1].type, equals(TokenType.eof));
  });

  test('scans the less', () {
    final tokens = Scanner('<').scanTokens();
    expect(tokens, hasLength(2));
    expect(tokens[0].type, equals(TokenType.less));
    expect(tokens[1].type, equals(TokenType.eof));
  });

  test('scans the less equal', () {
    final tokens = Scanner('<=').scanTokens();
    expect(tokens, hasLength(2));
    expect(tokens[0].type, equals(TokenType.lessEqual));
    expect(tokens[1].type, equals(TokenType.eof));
  });

  test('scans the greater', () {
    final tokens = Scanner('>').scanTokens();
    expect(tokens, hasLength(2));
    expect(tokens[0].type, equals(TokenType.greater));
    expect(tokens[1].type, equals(TokenType.eof));
  });

  test('scans the greater equal', () {
    final tokens = Scanner('>=').scanTokens();
    expect(tokens, hasLength(2));
    expect(tokens[0].type, equals(TokenType.greaterEqual));
    expect(tokens[1].type, equals(TokenType.eof));
  });

  test('scans the slash', () {
    final tokens = Scanner('/').scanTokens();
    expect(tokens, hasLength(2));
    expect(tokens[0].type, equals(TokenType.slash));
    expect(tokens[1].type, equals(TokenType.eof));
  });

  test('ignores comments', () {
    final tokens = Scanner('// This is a comment').scanTokens();
    expect(tokens, hasLength(1));
    expect(tokens[0].type, equals(TokenType.eof));
  });

  test('ignores spaces', () {
    final tokens = Scanner('   ').scanTokens();
    expect(tokens, hasLength(1));
    expect(tokens[0].type, equals(TokenType.eof));
  });

  test('ignores tabs', () {
    final tokens = Scanner('\t\t\t').scanTokens();
    expect(tokens, hasLength(1));
    expect(tokens[0].type, equals(TokenType.eof));
  });

  test('ignores \r characters', () {
    final tokens = Scanner('\r\r\r').scanTokens();
    expect(tokens, hasLength(1));
    expect(tokens[0].type, equals(TokenType.eof));
  });

  test('token column is identified correctly when there are multiple tokens',
      () {
    final tokens = Scanner('!= !=').scanTokens();
    expect(tokens[0].column, equals(1));
    expect(tokens[1].column, equals(4));
  });

  test('token line is identified correctly when there are multiple lines', () {
    final tokens = Scanner('!=\n!=').scanTokens();
    expect(tokens[0].line, equals(1));
    expect(tokens[1].line, equals(2));
    expect(tokens[1].column, equals(1));
  });

  test('scans string literals', () {
    final tokens = Scanner('"Hello, world!"').scanTokens();
    expect(tokens, hasLength(2));
    expect(tokens[0].type, equals(TokenType.string));
    expect(tokens[0].literal, equals('Hello, world!'));
    expect(tokens[1].type, equals(TokenType.eof));
  });

  test('scans strings that span multiple lines, and increments the line number',
      () {
    final tokens = Scanner('"Hello,\nworld!"').scanTokens();
    expect(tokens, hasLength(2));
    expect(tokens[0].type, equals(TokenType.string));
    expect(tokens[0].literal, equals('Hello,\nworld!'));
    expect(tokens[0].line, equals(1));
    expect(tokens[1].type, equals(TokenType.eof));
  });

  test(
      'when a string spans multiple line the next token has the correct line and column',
      () {
    final multiLineString = '"Hello,\nworld!"!=';
    final tokens = Scanner(multiLineString).scanTokens();

    expect(tokens, hasLength(3));
    expect(tokens[0].type, equals(TokenType.string));
    expect(tokens[0].literal, equals('Hello,\nworld!'));
    expect(tokens[0].line, equals(1));
    expect(tokens[0].column, equals(1));

    expect(tokens[1].type, equals(TokenType.bangEqual));
    expect(tokens[2].line, equals(2));
    expect(tokens[1].column, equals(8));
    expect(tokens[2].type, equals(TokenType.eof));
  });

  test('scans integers', () {
    final tokens = Scanner('123').scanTokens();
    expect(tokens, hasLength(2));
    expect(tokens[0].type, equals(TokenType.number));
    expect(tokens[0].literal, equals(123));
    expect(tokens[1].type, equals(TokenType.eof));
  });

  test('scans floats', () {
    final tokens = Scanner('123.456').scanTokens();
    expect(tokens, hasLength(2));
    expect(tokens[0].type, equals(TokenType.number));
    expect(tokens[0].literal, equals(123.456));
    expect(tokens[1].type, equals(TokenType.eof));
  });

  test('scans identifiers', () {
    final tokens = Scanner('foo').scanTokens();
    expect(tokens, hasLength(2));
    expect(tokens[0].type, equals(TokenType.identifier));
    expect(tokens[0].literal, equals('foo'));
    expect(tokens[1].type, equals(TokenType.eof));
  });

  test('scans reserved keywords', () {
    final tokens = Scanner('and class else false for fun if nil or'
        ' print return super this true var while continue').scanTokens();
    expect(tokens, hasLength(18));
    expect(tokens[0].type, equals(TokenType.keywordAnd));
    expect(tokens[1].type, equals(TokenType.keywordClass));
    expect(tokens[2].type, equals(TokenType.keywordElse));
    expect(tokens[3].type, equals(TokenType.keywordFalse));
    expect(tokens[4].type, equals(TokenType.keywordFor));
    expect(tokens[5].type, equals(TokenType.keywordFun));
    expect(tokens[6].type, equals(TokenType.keywordIf));
    expect(tokens[7].type, equals(TokenType.keywordNil));
    expect(tokens[8].type, equals(TokenType.keywordOr));
    expect(tokens[9].type, equals(TokenType.keywordPrint));
    expect(tokens[10].type, equals(TokenType.keywordReturn));
    expect(tokens[11].type, equals(TokenType.keywordSuper));
    expect(tokens[12].type, equals(TokenType.keywordThis));
    expect(tokens[13].type, equals(TokenType.keywordTrue));
    expect(tokens[14].type, equals(TokenType.keywordVar));
    expect(tokens[15].type, equals(TokenType.keywordWhile));
    expect(tokens[16].type, equals(TokenType.keywordContinue));
    expect(tokens[17].type, equals(TokenType.eof));
  });
}
