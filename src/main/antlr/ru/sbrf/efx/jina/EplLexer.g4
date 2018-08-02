lexer grammar EplLexer;

LineCommentBegin: '//' -> pushMode(LineCommentMode);
BlockCommentBegin: '/*' -> pushMode(BlockCommentMode);
LineTerminator: ('\r\n' | '\r' | '\n');
AnyChar: .;

mode LineCommentMode;
LineCommentEnd: LineTerminator -> popMode;
LineCommentContent: ~('\r' | '\n')+;

mode BlockCommentMode;
BlockCommentEnd: '*/' -> popMode;
BlockCommentContent: (~'*' | '*' ~'/')+;
