lexer grammar EplLexer;

channels { WhitespaceChannel, CommentChannel }

Utf8ByteOrderMarker: '\u00ef' '\u00bb' '\u00df' -> skip;

Whitespace: (AsciiWhitespace | UnicodeWhitespace)+ -> channel(WhitespaceChannel);

LineTerminator: ('\r\n' | '\r' | '\n');

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

OpenBrace: '{';
CloseBrace: '}';
OpenBracket: '[';
CloseBracket: ']';
OpenParen: '(';
CloseParen: ')';
Dot: '.';
Semicolon: ';';
Comma: ',';
Colon: ':';
Plus: '+';
Minus: '-';
Mult: '*';
Div: '/';
Mod: '%';
Lshift: '<<';
Rshift: '>>';
Assign: ':=';
Eq: '=';
Neq: '!=';
Lt: '<';
Gt: '>';
Le: '<=';
Ge: '=>';
Hash: '#';

Action: 'action';
Aggregate: 'aggregate';
All: 'all';
And: 'and';
As: 'as';
At: 'at';
Boolean: 'boolean';
Bounded: 'bounded';
Break: 'break';
Call: 'call';
Chunk: 'chunk';
Completed: 'completed';
Constant: 'constant';
Context: 'context';
Continue: 'continue';
CurrentTime: 'currentTime';
Decimal: 'decimal';
Dictionary: 'dictionary';
Die: 'die';
Else: 'else';
Emit: 'emit';
Enqueue: 'enqueue';
Event: 'event';
False: 'false';
Float: 'float';
For: 'for';
From: 'from';
If: 'if';
Import: 'import';
In: 'in';
Integer: 'integer';
Location: 'location';
Log: 'log';
Monitor: 'monitor';
New: 'new';
Not: 'not';
On: 'on';
Or: 'or';
Package: 'package';
Persistent: 'persistent';
Print: 'print';
Return: 'return';
Returns: 'returns';
Route: 'route';
Sequence: 'sequence';
Spawn: 'spawn';
Stream: 'stream';
Streamsource: 'streamsource';
String: 'string';
Then: 'then';
To: 'to';
True: 'true';
Unbounded: 'unbounded';
Using: 'using';
Usnmatched: 'usnmatched';
Wait: 'wait';
While: 'while';
Wildcard: 'wildcard';
Within: 'within';
Xor: 'xor';

CommonKeyword
    : Action
    | Aggregate
    | All
    | And
    | As
    | At
    | Boolean
    | Bounded
    | Break
    | Call
    | Chunk
    | Completed
    | Constant
    | Context
    | Continue
    | CurrentTime
    | Decimal
    | Dictionary
    | Die
    | Else
    | Emit
    | Enqueue
    | Event
    | False
    | Float
    | For
    | From
    | If
    | Import
    | In
    | Integer
    | Location
    | Log
    | Monitor
    | New
    | Not
    | On
    | Or
    | Package
    | Persistent
    | Print
    | Return
    | Returns
    | Route
    | Sequence
    | Spawn
    | Stream
    | Streamsource
    | String
    | Then
    | To
    | True
    | Unbounded
    | Using
    | Usnmatched
    | Wait
    | While
    | Wildcard
    | Within
    | Xor
    ;

By: 'by';
Every: 'every';
Group: 'group';
Having: 'having';
Join: 'join';
Largest: 'largest';
Partition: 'partition';
Retain: 'retain';
Rstream: 'rstream';
Select: 'select';
Smallest: 'smallest';
Unique: 'unique';
Where: 'where';
With: 'with';

StreamKeyword
    : By
    | Every
    | Group
    | Having
    | Join
    | Largest
    | Partition
    | Retain
    | Rstream
    | Select
    | Smallest
    | Unique
    | Where
    | With
    ;

CommonJustReserved
    : 'abstract'
    | 'assert'
    | 'bignum'
    | 'byte'
    | 'case'
    | 'catch'
    | 'char'
    | 'class'
    | 'default'
    | 'enum'
    | 'eval'
    | 'except'
    | 'extends'
    | 'finally'
    | 'FROM'
    | 'immutable'
    | 'implements'
    | 'instanceof'
    | 'interface'
    | 'JOIN'
    | 'native'
    | 'null'
    | 'otherwise'
    | 'private'
    | 'protected'
    | 'public'
    | 'runtime'
    | 'sortedsequence'
    | 'static'
    | 'super'
    | 'switch'
    | 'sync'
    | 'synchronized'
    | 'table'
    | 'throw'
    | 'throws'
    | 'transient'
    | 'try'
    | 'void'
    | 'volatile'
    | 'window'
    ;

StreamJustReserved
    : 'ALL'
    | 'AND'
    | 'BY'
    | 'EQUALS'
    | 'EVERY'
    | 'FALSE'
    | 'GROUP'
    | 'HAVING'
    | 'IN'
    | 'LARGEST'
    | 'NOT'
    | 'OR'
    | 'PARTITION'
    | 'RETAIN'
    | 'RSTREAM'
    | 'SELECT'
    | 'SMALLEST'
    | 'SYNC'
    | 'TRUE'
    | 'UNIQUE'
    | 'WHERE'
    | 'WITH'
    | 'WITHIN'
    ;

Reserved: Keyword | JustReserved;
Keyword: CommonKeyword | StreamKeyword;
JustReserved: CommonJustReserved | StreamJustReserved;

Identifier: EscapedReserved | JustIdentifier;
EscapedReserved: Hash Reserved;
JustIdentifier: Word Wordnum*;

Digit10S: Digit10+;
Digit16S: Digit16+;
StringLiteralChar: ~'\\' | '\\' [\\"tn];

fragment Alpha: [A-Za-z];
fragment Digit10: [0-9];
fragment Digit16: [0-9A-Fa-f];
fragment Word: Alpha | '_' | '$';
fragment Wordnum: Word | Digit10;
fragment Alnumic: Alpha | Digit10;

AnyChar: .;

mode LineCommentMode;
LineCommentEnd: LineTerminator -> popMode, channel(CommentChannel);
LineCommentContent: ~('\r' | '\n')+ -> channel(CommentChannel);

mode BlockCommentMode;
BlockCommentEnd: '*/' -> popMode, channel(CommentChannel);
BlockCommentContent: (~'*' | '*' ~'/')+ -> channel(CommentChannel);
