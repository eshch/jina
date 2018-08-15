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
block: OpenBrace statement* CloseBrace;

statement
    : expression
    | variableDefinition
    | emitStatement
    | enqueueStatement
    | logStatement
    | printStatement
    | routeStatement
    | spawnStatement
    | forStatement
    | fromStatement
    | ifStatement
    | onStatement
    | whileStatement
    | breakStatement
    | continueStatement
    | dieStatement
    | returnStatement
    ;

emitStatement: Emit expression To expression Semicolon;
enqueueStatement: Enqueue expression (To expression)? Semicolon;
logStatement: Log expression (At Identifier)? Semicolon;
printStatement: Print expression Semicolon;
routeStatement: Route expression Semicolon;
spawnStatement: Spawn actionCall (To expression)? Semicolon;
forStatement: For Identifier In expression block;
fromStatement: From /* stream grammar island */ Semicolon;
ifStatement: If expression Then block (Else (block | ifStatement))?;
onStatement: On eventExpression statement;
whileStatement: While expression block;
breakStatement: Break Semicolon;
continueStatement: Continue Semicolon;
dieStatement: Die Semicolon;
returnStatement: Return expression? Semicolon;

expression: Identifier; // TODO: replace stub
variableDefinition: dataType Identifier Semicolon; // TODO: initializer

actionCall: Identifier Semicolon;

eventExpression
    : OpenParen eventExpression CloseParen
    | (Unmatched | Completed)? eventTemplate
    | eventExpression Within OpenParen expression CloseParen
    | Wait OpenParen expression CloseParen
    | At OpenParen atTimes CloseParen
    ;

eventTemplate: Identifier OpenParen eventFilter? CloseParen Colon Identifier;
eventFilter
    : positionEventQualifierList
    | namedEventQualifierList
    | positionEventQualifierList Comma namedEventQualifierList
    ;
positionEventQualifierList: positionEventQualifier (Comma positionEventQualifier)*;
positionEventQualifier
    : Wildcard
    | rangeExpression
    | (Lt | Le | Gt | Ge | Eq)? expression
    ;
namedEventQualifierList: namedEventQualifier (Comma namedEventQualifier);
namedEventQualifier
    : Identifier
    ( Eq Wildcard
    | (Lt | Le | Gt | Ge | Eq) expression
    | In rangeExpression
    )
    ;
rangeExpression: (OpenParen | OpenBrace) expression Colon expression (CloseParen | CloseBrace);

atTimes: (atExpression Comma){4} atExpression (Comma atExpression)?;
atExpression
    : atPrimary
    | atList
    ;
atPrimary
    : Wildcard
    | Wildcard Div expression
    | expression Colon expression
    | expression
    ;
atList: OpenBrace atPrimary (Comma atPrimary)* CloseBrace;
