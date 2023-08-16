import 'lox.dart';
import 'token.dart';
import 'token_type.dart';

class Scanner {
  final String _source;
  final List<Token> _tokens = [];

  int _start = 0;
  int _current = 0;
  int _line = 1;
  int _column = 0;

  // reserved keywords
  static final Map<String, TokenType> _keywords = {
    "and": TokenType.keywordAnd,
    "class": TokenType.keywordClass,
    "else": TokenType.keywordElse,
    "false": TokenType.keywordFalse,
    "for": TokenType.keywordFor,
    "fun": TokenType.keywordFun,
    "if": TokenType.keywordIf,
    "nil": TokenType.keywordNil,
    "or": TokenType.keywordOr,
    "print": TokenType.keywordPrint,
    "return": TokenType.keywordReturn,
    "super": TokenType.keywordSuper,
    "this": TokenType.keywordThis,
    "true": TokenType.keywordTrue,
    "var": TokenType.keywordVar,
    "while": TokenType.keywordWhile,
    "continue": TokenType.keywordContinue,
  };

  Scanner(this._source);

  List<Token> scanTokens() {
    while (!_isAtEnd()) {
      // We are at the beginning of the next lexeme.
      _start = _current;
      _scanToken();
    }

    _tokens.add(Token(
      type: TokenType.eof,
      lexeme: "",
      literal: null,
      line: _line,
      column: _column,
    ));
    return _tokens;
  }

  void _scanToken() {
    final c = _advance();
    switch (c) {
      case '(':
        _addToken(TokenType.leftParen);
      case ')':
        _addToken(TokenType.rightParen);
      case '{':
        _addToken(TokenType.leftBrace);
      case '}':
        _addToken(TokenType.rightBrace);
      case ',':
        _addToken(TokenType.comma);
      case '.':
        _addToken(TokenType.dot);
      case '-':
        _addToken(TokenType.minus);
      case '+':
        _addToken(TokenType.plus);
      case ';':
        _addToken(TokenType.semicolon);
      case '*':
        _addToken(TokenType.star);
      case '!':
        _addToken(_match('=') ? TokenType.bangEqual : TokenType.bang);
      case '=':
        _addToken(_match('=') ? TokenType.equalEqual : TokenType.equal);
      case '<':
        _addToken(_match('=') ? TokenType.lessEqual : TokenType.less);
      case '>':
        _addToken(_match('=') ? TokenType.greaterEqual : TokenType.greater);
      case '/':
        if (_match('/')) {
          // A comment goes until the end of the line.
          while (_peek() != '\n' && !_isAtEnd()) {
            _advance();
          }
        } else {
          _addToken(TokenType.slash);
        }
      case ' ' || '\r' || '\t':
        // Ignore whitespace.
        break;
      case '\n':
        _line++;
        _column = 0;
      case '"':
        _string();
      default:
        if (_isDigit(c)) {
          _number();
        } else if (_isAlpha(c)) {
          _identifier();
        } else {
          Lox.error(_line, "Unexpected character.");
        }
    }
  }

  String _advance() {
    _current++;
    final currentString = _source[_current - 1];
    if (currentString == '\n') {
      _column = 0;
    } else {
      _column++;
    }
    return currentString;
  }

  /// Adds a token to the list of tokens.
  void _addToken(TokenType type, [Object? literal, int? line, int? column]) {
    line ??= _line;
    String text = _source.substring(_start, _current);
    // The column is the current column, minus the length of the text,
    // unless specified.
    column ??= (_column - text.length) + 1;

    _tokens.add(Token(
      type: type,
      lexeme: text,
      literal: literal,
      line: line,
      column: column,
    ));
  }

  /// Checks if the character at [current] matches the received
  /// [character]. If it does, it advances [current] and returns
  /// true. Otherwise, it returns false without advancing.
  bool _match(String character) {
    if (_isAtEnd()) return false;
    if (_source[_current] != character) return false;

    _column++;
    _current++;
    return true;
  }

  /// Whether we've reached the end of the source code.
  bool _isAtEnd() {
    return _current >= _source.length;
  }

  String? _peek() {
    if (_isAtEnd()) return null;
    return _source[_current];
  }

  void _string() {
    // keep track of where the line and column started
    int line = _line;
    int column = _column;
    while (_peek() != '"' && !_isAtEnd()) {
      if (_peek() == '\n') {
        _line++;
      }
      _advance();
    }

    // Unterminated string.
    if (_isAtEnd()) {
      Lox.error(_line, "Unterminated string.");
      return;
    }

    // The closing ".
    _advance();

    // Trim the surrounding quotes.
    String value = _source.substring(_start + 1, _current - 1);

    _addToken(TokenType.string, value, line, column);
  }

  bool _isDigit(String? character) {
    if (character == null) return false;
    return character.compareTo('0') >= 0 && character.compareTo('9') <= 0;
  }

  void _number() {
    while (_isDigit(_peek())) {
      _advance();
    }

    // Look for a fractional part.
    if (_peek() == '.' && _isDigit(_peekNext())) {
      // Consume the "."
      _advance();

      while (_isDigit(_peek())) {
        _advance();
      }
    }

    _addToken(
      TokenType.number,
      double.parse(_source.substring(_start, _current)),
    );
  }

  String? _peekNext() {
    if (_current + 1 >= _source.length) return null;
    return _source[_current + 1];
  }

  bool _isAlpha(String character) {
    return (character.compareTo('a') >= 0 && character.compareTo('z') <= 0) ||
        (character.compareTo('A') >= 0 && character.compareTo('Z') <= 0) ||
        character == '_';
  }

  void _identifier() {
    while (_isAlphaNumeric(_peek())) {
      _advance();
    }

    // See if the identifier is a reserved word.
    String text = _source.substring(_start, _current);
    TokenType? type = _keywords[text];
    type ??= TokenType.identifier;
    _addToken(type, text);
  }

  bool _isAlphaNumeric(String? peek) {
    if (peek == null) return false;
    return _isAlpha(peek) || _isDigit(peek);
  }
}
