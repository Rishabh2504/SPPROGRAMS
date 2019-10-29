%{
	#include<stdio.h>
	int i;
%}

Pstar \*+
Knostar [^*]*
Nostarfwdslash [^*/]


%%

\"((\\\")|[^"])*\" ;

"/*"{Knostar}{Pstar}({Nostarfwdslash}{Knostar}{Pstar})*"/" ;
(\/\/.*) ;

#.* ;

and|bool|break|case|catch|char|class|const|define|do|double|enum|explicit|export|extern|false|float ;
for|goto|if|import|inline|int|long|mutable|namespace|new|not|requires|return|short|signed|sizeof ;
static|struct|switch|synchronized|template|this|throw|true|try|typedef|typeid|typename|union|unsigned ;
using|continue|virtual|operator|void|or|volatile|private|while|default|protected|xor|delete|public|register ;

[A-Za-z_][A-Za-z0-9_]* {i++;}

.|\n ;

 
%%
 

int main()
{	
	yyin=fopen("comment.cpp","r");
	yylex();
	printf("Number of identifier : %d\n",i);
	return 0; 
}

int yywrap()
{
return 1;
}
