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

dataType
    : Boolean # boolean
    | Decimal # decimal
    | Float # float
    | Integer # integer
    | String # string
    | Action Lt dataType (Comma dataType)* Gt (Returns dataType)? # action
    | Chunk # chunk
    | Context # context
    | Dictionary Lt dataType Comma dataType Gt # dictionary
    | Identifier # event
    | Listener # listener
    | Location # location
    | Sequence Lt dataType Gt # sequence
    | Stream Lt dataType Gt # stream
    ;

eventFieldDefinition: Wildcard? dataType Identifier Semicolon;

eventActionDefinition: Action Identifier parametersDefinition? (Returns dataType)? block;
parametersDefinition: OpenParen (parameterDefinition (Comma parameterDefinition)*)? CloseParen;
parameterDefinition: dataType Identifier;
block: OpenBrace CloseBrace;
