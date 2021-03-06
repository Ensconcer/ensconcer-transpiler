grammar datatypes;

import keywords;

//test: literal (('\r'? '\n')+ literal)* ('\r'? '\n')* ('//' | EOF);

literal : numericalValue | String | selector;

selector : SelectorType ('[' selectorOptions? ']')?;

selectorOptions: selectorOption (',' selectorOption)*;

selectorOption: rangeSelectorOption '='  numericalRange
              | unquotedSelectorOption '=' '!'? unquotedString
              | quotedSelectorOption '=' '!'? (String | unquotedString)
              | intSelectorOption '=' '!'? Int
              | 'sort' '=' sortSelectorOption
              | 'gamemode' '=' '!'? gamemodeSelectorOption
              | 'type' '=' '!'? shortEntityTypes
              | 'scores' '=' scoresSelectorOption
              ;


numericalRange: Range | decimal;
numericalValue: Bool | SIGN? unsignedNumericalValue;
unsignedNumericalValue : Byte | Short | Long | Int | Float | Double;

SelectorType : '@' [apres];



Bool : T R U E | F A L S E;
Byte : WHOLE_NUMBER B;
Short : WHOLE_NUMBER S;
Long : WHOLE_NUMBER L;
Int : WHOLE_NUMBER;

Float : DECIMAL F;
Double : DECIMAL D;

Range: WHOLE_NUMBER '..' WHOLE_NUMBER? | '..' WHOLE_NUMBER;


String : '"' ((ESCAPE | ~["\r\n])*) '"';

// TODO: Check for whitespace
unquotedString: ( Character
                | Sign
                | '.'
                | numericalValue
                | Id
                | numericalRange
                | keyword
                )+
                ;

decimal: Decimal | Int;

Sign: [+-];
selectorScore: unquotedString '=' numericalRange;
scoresSelectorOption: '{' (selectorScore (',' selectorScore)*)? '}';

Id : [a-zA-Z_] [0-9a-zA-Z_-]*;
Character : [0-9a-zA-Z_];
fragment DIGITS : [0-9]+;
fragment HEX_DIGIT : [0-9a-fA-F];
fragment INTEGER_PART : DIGITS;
fragment FRACTIONAL_PART : '.' DIGITS;
fragment WHOLE_NUMBER : INTEGER_PART;
fragment DECIMAL : INTEGER_PART FRACTIONAL_PART?
                 | FRACTIONAL_PART;
fragment ESCAPE : '\\' [n\\"]
                | '\\u' HEX_DIGIT HEX_DIGIT HEX_DIGIT HEX_DIGIT;

// Fragments used for case insensitive matching
fragment A : [aA];
fragment B : [bB];
fragment D : [dD];
fragment E : [eE];
fragment F : [fF];
fragment L : [lL];
fragment R : [rR];
fragment S : [sS];
fragment T : [tT];
fragment U : [uU];


WS: (' ' | '\t')+ -> skip;

