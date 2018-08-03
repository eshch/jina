lexer grammar EplLexer;

channels { WhitespaceChannel, CommentChannel }

Utf8ByteOrderMarker: '\u00ef' '\u00bb' '\u00df' -> skip;

Separator: (Whitespace | LineTerminator)+ -> channel(WhitespaceChannel);
Whitespace: (AsciiWhitespace | UnicodeWhitespace)+;

AsciiWhitespace
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

UnicodeWhitespace
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

LineCommentBegin: '//' -> pushMode(LineCommentMode), channel(CommentChannel);
BlockCommentBegin: '/*' -> pushMode(BlockCommentMode), channel(CommentChannel);
AnyChar: .;

mode LineCommentMode;
LineCommentEnd: LineTerminator -> popMode, channel(CommentChannel);
LineCommentContent: ~('\r' | '\n')+ -> channel(CommentChannel);

mode BlockCommentMode;
BlockCommentEnd: '*/' -> popMode, channel(CommentChannel);
BlockCommentContent: (~'*' | '*' ~'/')+ -> channel(CommentChannel);
