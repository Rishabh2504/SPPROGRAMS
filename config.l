%%

". " ;


%%

int main()
{
	yyin=fopen("config.txt","r");
	yylex();
	return 0;
}

int yywrap()
{
	return 1;
}	
