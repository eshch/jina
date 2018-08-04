parser grammar EplParser;
options { tokenVocab=EplLexer; }

comment: lineComment | blockComment;
lineComment: LineCommentBegin LineCommentContent? LineCommentEnd?;
blockComment: BlockCommentBegin BlockCommentContent? BlockCommentEnd;

programFile: Utf8ByteOrderMarker? programText EOF;
programText:
    packageDeclaration?
    usingDeclaration*
    (eventDefinition /*| monitorDefinition | customAggregateDefinition*/)*
    ;

packageDeclaration: Package Identifier (Dot Identifier)* Semicolon;
usingDeclaration: Using Identifier (Dot Identifier)* Semicolon;
eventDefinition: Event Identifier OpenBrace eventMemberDefinition* CloseBrace;
eventMemberDefinition: eventFieldDefinition | eventActionDefinition;

dataTypeDefinition: Identifier;

eventFieldDefinition: Wildcard? dataTypeDefinition Identifier Semicolon;

eventActionDefinition: Action Identifier parametersDefinition? (Returns dataTypeDefinition)? block;
parametersDefinition: OpenParen (parameterDefinition (Comma parameterDefinition)*)? CloseParen;
parameterDefinition: dataTypeDefinition Identifier;
block: OpenBrace CloseBrace;
