parser grammar EplParser;
options { tokenVocab=EplLexer; }

programFile: Utf8ByteOrderMarker? programText* EOF;
programText
    : Separator
    | comment
    ;

comment: lineComment | blockComment;

lineComment: LineCommentBegin lineCommentContent LineCommentEnd?;
lineCommentContent: LineCommentContent?;

blockComment: BlockCommentBegin blockCommentContent BlockCommentEnd;
blockCommentContent: BlockCommentContent?;
