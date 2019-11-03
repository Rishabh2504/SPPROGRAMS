%{
	#include<stdio.h>
	
	int lcount;
	int count;
	int wcount;
	int bscount;
%}


%%
 
 
\n {
	lcount++;
	count++;
}

[\t ]	{
	 bscount++;
	 count++;
}

[a-zA-Z]+ {
			wcount++;
			count+=yyleng;
}

. {count++;}
 
%%
 
 
int main()
{	
	yyin=fopen("prog6.txt","r");
 	yylex();
 	printf("\nNumber of lines : %d\nNumber of characters : %d\nNumber of Words : %d\nNumber of Blank Spaces : %d\n",lcount,count,wcount,bscount);
	return 0; 
}

int yywrap()
{
return 1;
}
