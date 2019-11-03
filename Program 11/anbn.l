%{
    #include <stdio.h> 
    #include "y.tab.h"
%}

%%

[\n]    return NEWLINE;
.       return *yytext;

%%

int yywrap()
{
	return 1;
}