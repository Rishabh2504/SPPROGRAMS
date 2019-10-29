%{
	#include<stdio.h>
	
	int id;
	int mc;
	int sc;
	int key;
	int i;
	int f;
	int op;
	
%}

Pstar \*+
Knostar [^*]*
Nostarfwdslash [^*/]


%%

\"((\\\")|[^"])*\" ;
#.* ;
"/*"{Knostar}{Pstar}({Nostarfwdslash}{Knostar}{Pstar})*"/" {mc++; printf("\nMultiline Comment :\n%s",yytext);}
(\/\/.*) {sc++; printf("\nSingle Line Comment :\n%s",yytext);}

and|bool|break|case|catch|char|class|const|define|do|double|enum|explicit|export|extern|false|float {printf("\nKeyword : %s",yytext); key++;}
for|goto|if|import|inline|int|long|mutable|namespace|new|not|requires|return|short|signedstatic {printf("\nKeyword : %s",yytext); key++;}
struct|switch|synchronized|template|this|throw|true|try|typedef|typeid|typename|union|unsigned {printf("\nKeyword : %s",yytext); key++;}
using|continue|virtual|operator|void|or|volatile|private|while|default|protected|xor|delete|public|register {printf("\nKeyword : %s",yytext); key++;}

[A-Za-z_][A-Za-z0-9_]* {printf("\nIdentifier : %s",yytext); id++;}

"+"|"-"|"*"|"/"|"%"|"++"|"--" {printf("\nOperator : %s",yytext); op++;}
"=="|"!="|">"|"<"|">="|"<="  {printf("\nOperator : %s",yytext); op++;}
"&&"|"||"|"!" {printf("\nOperator : %s",yytext); op++;}
"&"|"|"|"^"|"~"|"<<"|">>" {printf("\nOperator : %s",yytext); op++;}
"="|"+="|"-="|"*="|"/="|"%="|"&="|"|="|"^="|"<<="|">>=" {printf("\nOperator : %s",yytext); op++;}
"sizeof"|"."|"?"|"->"|"," {printf("\nOperator : %s",yytext); op++;}

[-+]?[0-9]+ {printf("\nInteger : %s",yytext); i++;}

[-+]?[0-9]+\.[0-9]+ {printf("\nFloat : %s",yytext); f++;}

.|\n ;

 
%%
 

int main()
{	
	yyin=fopen("comment.cpp","r");
	yylex();
	printf("\n\nNumber of keywords : %d\nNumber of Integers : %d\nNumber of Floats : %d\nNumber of identifier : %d\nNumber of Operators : %d\n",key,i,f,id,op);
	printf("Single Line Comments : %d\nMultiple Line Comments : %d\n",sc,mc);
	return 0; 
}

int yywrap()
{
return 1;
}
