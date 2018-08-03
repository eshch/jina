parser grammar EplParser;
options { tokenVocab=EplLexer; }

programFile: Utf8ByteOrderMarker? programText EOF;
programText: packageDeclaration? usingDeclaration*;

packageDeclaration: Package Identifier (Dot Identifier)* Semicolon;
usingDeclaration: Using Identifier (Dot Identifier)* Semicolon;

comment: lineComment | blockComment;

lineComment: LineCommentBegin lineCommentContent LineCommentEnd?;
lineCommentContent: LineCommentContent?;

blockComment: BlockCommentBegin blockCommentContent BlockCommentEnd;
blockCommentContent: BlockCommentContent?;
