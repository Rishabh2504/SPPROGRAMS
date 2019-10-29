%{
	#include<stdio.h>
	int mc=0;
	int sc=0;
%}

Pstar \*+
Knostar [^*]*
Nostarfwdslash [^*/]


%%

\"((\\\")|[^"])*\" ;

"/*"{Knostar}{Pstar}({Nostarfwdslash}{Knostar}{Pstar})*"/" {mc++; printf("\nMultiline Comment :\n%s",yytext);}

(\/\/.*) {sc++; printf("\nSingle Line Comment :\n%s",yytext);}

.|\n ;

%%
 

int main()
{	
	yyin=fopen("comment.cpp","r");
 	yylex();
 	printf("\nSingle Line Comments : %d\nMultiple Line Comments : %d\n",sc,mc);
	return 0; 
}

int yywrap()
{
return 1;
}
