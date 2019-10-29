%{
	#include<stdio.h>
%}

Pstar \*+
Knostar [^*]*
Nostarfwdslash [^*/]


%%

\"((\\\")|[^"])*\" {printf(yytext);}
"/*"{Knostar}{Pstar}({Nostarfwdslash}{Knostar}{Pstar})*"/"\n* ;
(\/\/.*)\n+ ;


%% 

int main()
{	
	yyin=fopen("comment.cpp","r");
 	yylex();
	return 0; 
}

int yywrap()
{
return 1;
}
