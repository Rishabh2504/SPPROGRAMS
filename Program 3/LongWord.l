%{

	#include<string.h>
	int len=0;
	char*ch;
	
%}


%%
 
 
[a-zA-Z]+ {
	
	if(yyleng >len)
	{	
		free(ch);
		ch=(char*)malloc(yyleng+1);
		strcpy(ch,yytext);
		len=yyleng;
	}

}


%%
 
 
int main()
{	
	yyin=fopen("prog3.txt","r");
 	yylex();
	printf("\nLongest word is %s with length %d\n",ch,len);
	return 0; 
}

int yywrap()
{
return 1;
}
