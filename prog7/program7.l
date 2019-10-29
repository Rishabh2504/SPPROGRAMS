%%

.*  {
    int i, j;
    for(i=0;i<yyleng;i++)
    {
        for(j=0;j<(yyleng-i);j++)
        {
            printf("%c",yytext[j]);
        }
        printf("\n");
    }
}

%%

int main()
{
    yylex();
    return 0;
}

int yywrap()
{
return 1;
}
