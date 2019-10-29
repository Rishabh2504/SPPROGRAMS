%{
	char ch;
%}
%%
 
 
[a-zA-Z] {
	ch=yytext[0];
	if(ch<=90)
	printf("%c",((ch-65+3)%26 + 65));
	else
	printf("%c",((ch-97+3)%26 + 97));
}


 
%%
 
 
int main()
{	
	yyin=fopen("prog2.txt","r");
 	yylex();
	return 0; 
}

int yywrap()
{
return 1;
}

