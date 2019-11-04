%{
    #include <stdio.h>
    #include <stdlib.h>
%}
%union{
    char* s;
}

%token VAR NEWLINE 
%left '+' '-'
%left '*' '/' '%'

%type <s> VAR

%%

start: expr NEWLINE  {
                        printf("\nValid Expression\n");
                        exit(1);
                      }
  ;

expr:  expr '+' expr    {printf("+ ");}
  | expr '-' expr       {printf("- ");}
  | expr '*' expr       {printf("* ");}
  | expr '/' expr       {printf("/ ");}
  | expr '%' expr       {printf("%%");}
  | '(' expr ')'
  | '-' expr             {printf("- ");}
  | '+' expr             {printf("+ ");}
  | VAR                  {printf("%s",$1);}
  ;

%%

int yyerror(char const *s)
{
    printf("Invalid Expression  %s\n",s);
    return 0;
}
int main()
{
  printf("Enter The Expression\n");
  yyparse();
  return 1;
}