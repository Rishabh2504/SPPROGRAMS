%{
  #include <stdio.h> 
	#include "y.tab.h"
%}

%%


[0-9]*(\.[0-9]+)?	{
          yylval.f = atof(yytext);
          return FLOAT;
        }

[\n]    return NEWLINE;
.       return *yytext;

%%

int yywrap()
{
	return 1;
}