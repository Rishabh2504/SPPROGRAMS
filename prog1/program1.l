%{
	int lcount;
	int count;
%}


%%
 
 
\n {
	lcount++;
	count++;
}

. {
	count++;
}

 
%%
 
 
int main()
{	
	yyin=fopen("prog1.txt","r");
 	yylex();
 	printf("\nNumber of lines : %d\nNumber of characters : %d\n",lcount,count);
	return 0; 
}

int yywrap()
{
return 1;
}

