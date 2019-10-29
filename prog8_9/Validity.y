%{
    #include <stdio.h>
    #include <stdlib.h>
%}

%token DIGIT NEWLINE VAR
%left '+' '-'
%left '*' '/' '%'

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
  | DIGIT                {printf("%d ",$1);}
  | VAR                  {printf("%c ",$1)}
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