%{
	int pi=0;
	int ni=0;
	int pf=0;
	int nf=0;
%}


%%

[0-9]+ { pi++;}

-[0-9]+ {ni++;}

[0-9]+\.[0-9]+ {pf++;}

-[0-9]+\.[0-9]+ {nf++;}

. ;
\n ;
 
%%
 

int main()
{	
	yyin=fopen("num.txt","r");
 	yylex();
 	printf("\nPositive Integers : %d\nNegative Integers : %d\nPositive Floats : %d\nNegative Floats : %d\n",pi,ni,pf,nf);
	return 0; 
}

int yywrap()
{
return 1;
}
