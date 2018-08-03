lexer grammar EplLexer;

Utf8ByteOrderMarker: '\u00ef' '\u00bb' '\u00df' -> skip;

Separator: (WhiteSpace | LineTerminator)+ -> skip;
WhiteSpace: (AsciiWhiteSpace | UnicodeWhiteSpace)+;

AsciiWhiteSpace
    : LineTerminator
    | ' '
    | '\t'
    | '\f'
    | '\u001c'
    | '\u001d'
    | '\u001e'
    | '\u001f'
    ;

LineTerminator: ('\r\n' | '\r' | '\n');

UnicodeWhiteSpace
    : '\u0085'
    | '\u00a0'
    | '\u1680'
    | '\u180e'
    | '\u2000'
    | '\u2001'
    | '\u2002'
    | '\u2003'
    | '\u2004'
    | '\u2005'
    | '\u2006'
    | '\u2007'
    | '\u2008'
    | '\u2009'
    | '\u200a'
    | '\u2028'
    | '\u2029'
    | '\u202f'
    | '\u205f'
    | '\u3000'
    ;

LineCommentBegin: '//' -> pushMode(LineCommentMode);
BlockCommentBegin: '/*' -> pushMode(BlockCommentMode);
AnyChar: .;

mode LineCommentMode;
LineCommentEnd: LineTerminator -> popMode;
LineCommentContent: ~('\r' | '\n')+;

mode BlockCommentMode;
BlockCommentEnd: '*/' -> popMode;
BlockCommentContent: (~'*' | '*' ~'/')+;
