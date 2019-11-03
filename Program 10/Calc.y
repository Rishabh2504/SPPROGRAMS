%{
    #include <stdio.h>
    #include <stdlib.h>
%}
%union {
        float f;
}
%token FLOAT NEWLINE
%type <f> FLOAT expr start 
%left '+' '-'
%left '*' '/'
%right UADD UMINUS

%%

start: expr NEWLINE  {
                        printf("\nAnswer = %f\n",$1);
                        exit(1);
                    }
  ;

expr:  expr '+' expr    {$$=$1+$3;}
  | expr '-' expr       {$$=$1-$3;}
  | expr '*' expr       {$$=$1*$3;}
  | expr '/' expr       {
                            if($3==0.0)
                            {
                                yyerror("Divide By Zero!\n");
                            }
                            $$=$1/$3;
                        }
  | '(' expr ')'        {$$=$2;}
  | '-' expr  %prec UMINUS  {$$=-$2;}
  | '+' expr  %prec UADD    {$$=$2;}
  | FLOAT   ;
  ;


%%

int yyerror(char const *s)
{
    printf("Invalid Expression!\n%s",s);
    return 0;
}
int main()
{
  printf("Enter The Expression\n");
  yyparse();
  return 1;
}