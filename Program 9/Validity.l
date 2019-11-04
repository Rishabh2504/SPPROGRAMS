%{
	#include <stdio.h> 
	#include "y.tab.h"
%}

%%

[a-zA-Z][a-zA-Z0-9]*    {
							yylval.s=yytext;
							return VAR;
						}
[\n]                    return NEWLINE;
.                       return *yytext;

%%

int yywrap()
{
	return 1;
}