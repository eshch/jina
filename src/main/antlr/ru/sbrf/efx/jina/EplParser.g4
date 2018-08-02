parser grammar EplParser;
options { tokenVocab=EplLexer; }

programFile: programText* EOF;
programText
    : comment
    ;

comment: lineComment | blockComment;

lineComment: LineCommentBegin lineCommentContent LineCommentEnd?;
lineCommentContent: LineCommentContent?;

blockComment: BlockCommentBegin blockCommentContent BlockCommentEnd;
blockCommentContent: BlockCommentContent?;
