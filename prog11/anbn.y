%{
    #include <stdio.h>
    #include <stdlib.h>
%}

%token NEWLINE


%%

start: ptrn NEWLINE  {
                        printf("\nValid Expression\n");
                        exit(1);
                      }
  ;

ptrn: 'a' ptrn 'b'
    | 'a''b'
  ;

%%

int yyerror(char const *s)
{
    printf("\nInvalid Expression \n");
    return 0;
}
int main()
{
  printf("Enter The Expression\n");
  yyparse();
  return 1;
}