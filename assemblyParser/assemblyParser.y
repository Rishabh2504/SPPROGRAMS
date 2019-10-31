%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    int yylex();
    int yyerror();
    extern FILE *yyin;
    extern FILE *yyout;
    int lc;
    char *arr;
    struct identifier {
        char* id;
        int loc;
    };
    struct identifier symtab[10];
    int ids;
    int temp, temp2, location;
%}

%token DD
%token MVI
%token LOADI
%token ADD
%token MOV
%token INC
%token CMP
%token JE
%token ADDI
%token JMP
%token STORE
%token STOP
%token SPACE
%token NUMBER
%token ID
%token NEWLINE
%token COMMENT
%token A
%token B
%token C
%token I
%token STORI
%token LOAD

%union{
    char* s;
    int i;
}

%type <i> NUMBER
%type <s> ID

%%

start: statement_list NEWLINE STOP {
            printf("Program syntactically correct\n");
            return 0;
        }
    ;

statement_list:  statement                 
    | statement_list NEWLINE statement 
    ;

statement: 
    | ID ':' SPACE instr optionComment  {
        symtab[ids].id = $1; 
        symtab[ids].loc = lc;
        ids++;
        lc += temp2;
        temp2 = 0;
    }
    
    | instr optionComment   {
        lc += temp2;
        temp2 = 0;
    }
    ;

optionComment:
    | SPACE COMMENT 
    ;

instr: ID SPACE DD SPACE number_list    { 
        symtab[ids].id = $1; 
        symtab[ids].loc = lc;
        ids++;
        temp2 += temp;
        temp = 0;
    }
    
    | MVI SPACE A ',' NUMBER    { 
        fprintf(yyout, "00");
        char a, b;
        if($5 / 16 > 9)
            a = (char)($5 / 16 + 55);
        else
            a = (char)($5 / 16 + 48);
        if($5 % 16 > 9)
            b = (char)($5 % 16 + 55);
        else
            b = (char)($5 % 16 + 48);
        fprintf(yyout, "%c%c000000\n", a, b);
        temp2 += 5; 
    }
    
    | MVI SPACE A ',' ID    { 
        fprintf(yyout, "00");
        char a, b;
        int k = -1;
        for(int i = 0; i < ids; i++){
            if(!strcmp(symtab[i].id, $5)){
                k = i;
                break;
            }
        }
        if(k == -1)
            location = 255;             //invalid or forward reference
        else
            location = symtab[k].loc;
        if(location / 16 > 9)
            a = (char)(location / 16 + 55);
        else
            a = (char)(location / 16 + 48);
        if(location % 16 > 9)
            b = (char)(location % 16 + 55);
        else
            b = (char)(location % 16 + 48);
        fprintf(yyout, "%c%c000000\n", a, b);
        temp2 += 5; 
    }
    
    | MVI SPACE B ',' NUMBER    { 
        fprintf(yyout, "01");
        char a, b;
        if($5 / 16 > 9)
            a = (char)($5 / 16 + 55);
        else
            a = (char)($5 / 16 + 48);
        if($5 % 16 > 9)
            b = (char)($5 % 16 + 55);
        else
            b = (char)($5 % 16 + 48);
        fprintf(yyout, "%c%c000000\n", a, b);
        temp2 += 5; 
    }
    
    | MVI SPACE B ',' ID    { 
        fprintf(yyout, "01");
        char a, b;
        int k = -1;
        for(int i = 0; i < ids; i++){
            if(!strcmp(symtab[i].id, $5)){
                k = i;
                break;
            }
        }
        if(k == -1)
            location = 255;             //invalid or forward reference
        else
            location = symtab[k].loc;
        if(location / 16 > 9)
            a = (char)(location / 16 + 55);
        else
            a = (char)(location / 16 + 48);
        if(location % 16 > 9)
            b = (char)(location % 16 + 55);
        else
            b = (char)(location % 16 + 48);
        fprintf(yyout, "%c%c000000\n", a, b);
        temp2 += 5; 
    }
    
    | MVI SPACE C ',' NUMBER    { 
        fprintf(yyout, "02");
        char a, b;
        if($5 / 16 > 9)
            a = (char)($5 / 16 + 55);
        else
            a = (char)($5 / 16 + 48);
        if($5 % 16 > 9)
            b = (char)($5 % 16 + 55);
        else
            b = (char)($5 % 16 + 48);
        fprintf(yyout, "%c%c000000\n", a, b);
        temp2 += 5; 
    }
    
    | MVI SPACE C ',' ID    { 
        fprintf(yyout, "02");
        char a, b;
        int k = -1;
        for(int i = 0; i < ids; i++){
            if(!strcmp(symtab[i].id, $5)){
                k = i;
                break;
            }
        }
        if(k == -1)
            location = 255;                 //invalid or forward reference
        else
            location = symtab[k].loc;
        if(location / 16 > 9)
            a = (char)(location / 16 + 55);
        else
            a = (char)(location / 16 + 48);
        if(location % 16 > 9)
            b = (char)(location % 16 + 55);
        else
            b = (char)(location % 16 + 48);
        fprintf(yyout, "%c%c000000\n", a, b);
        temp2 += 5; 
    }
    
    | MVI SPACE I ',' NUMBER    { 
        fprintf(yyout, "03");
        char a, b;
        if($5 / 16 > 9)
            a = (char)($5 / 16 + 55);
        else
            a = (char)($5 / 16 + 48);
        if($5 % 16 > 9)
            b = (char)($5 % 16 + 55);
        else
            b = (char)($5 % 16 + 48);
        fprintf(yyout, "%c%c000000\n", a, b);
        temp2 += 5; 
    }
    
    | MVI SPACE I ',' ID    { 
        fprintf(yyout, "03");
        char a, b;
        int k = -1;
        
        for(int i = 0; i < ids; i++){
            if(!strcmp(symtab[i].id, $5)){
                k = i;
                break;
            }
        }
        if(k == -1)
            location = 255;                     //invalid or forward reference
        else
            location = symtab[k].loc;
        if(location / 16 > 9)
            a = (char)(location / 16 + 55);
        else
            a = (char)(location / 16 + 48);
        if(location % 16 > 9)
            b = (char)(location % 16 + 55);
        else
            b = (char)(location % 16 + 48);
        fprintf(yyout, "%c%c000000\n", a, b);
        temp2 += 5; 
    }
    
    | LOAD SPACE NUMBER     { 
        fprintf(yyout, "04");
        char a, b;
        if($3 / 16 > 9)
            a = (char)($3 / 16 + 55);
        else
            a = (char)($3 / 16 + 48);
        if($3 % 16 > 9)
            b = (char)($3 % 16 + 55);
        else
            b = (char)($3 % 16 + 48);
        fprintf(yyout, "%c%c000000\n", a, b);
        temp2 += 5; 
    }
    
    | LOAD SPACE ID     { 
        fprintf(yyout, "04");
        char a, b;
        int k = -1;
        for(int i = 0; i < ids; i++){
            if(!strcmp(symtab[i].id, $3)){
                k = i;
                break;
            }
        }
        if(k == -1)
            location = 255;
        else
            location = symtab[k].loc;
        if(location / 16 > 9)
            a = (char)(location / 16 + 55);
        else
            a = (char)(location / 16 + 48);
        if(location % 16 > 9)
            b = (char)(location % 16 + 55);
        else
            b = (char)(location % 16 + 48);
        fprintf(yyout, "%c%c000000\n", a, b);
        temp2 += 5; 
    }
    
    | STORE SPACE ID    { 
        fprintf(yyout, "05");
        char a, b;
        int k = -1;
        for(int i = 0; i < ids; i++){
            if(!strcmp(symtab[i].id, $3)){
                k = i;
                break;
            }
        }
        if(k == -1)
            location = 255;
        else
            location = symtab[k].loc;
        if(location / 16 > 9)
            a = (char)(location / 16 + 55);
        else
            a = (char)(location / 16 + 48);
        if(location % 16 > 9)
            b = (char)(location % 16 + 55);
        else
            b = (char)(location % 16 + 48);
        fprintf(yyout, "%c%c000000\n", a, b);
        temp2 += 5; 
    }
    
    | LOADI     { 
        fprintf(yyout, "06\n");
        temp2 += 1; 
    }
    
    | STORI     { 
        fprintf(yyout, "07\n");
        temp2 += 1; 
    }
    
    | ADD SPACE B   { 
        fprintf(yyout, "08\n");
        temp2 += 1; 
    }
    
    | ADD SPACE C   { 
        fprintf(yyout, "09\n");
        temp2 += 1; 
    }
    
    | MOV SPACE A ',' B     { 
        fprintf(yyout, "0A\n");
        temp2 += 1; 
    }
    
    | MOV SPACE A ',' C     { 
        fprintf(yyout, "0B\n");
        temp2 += 1; 
    }
    
    | MOV SPACE B ',' C     { 
        fprintf(yyout, "0C\n");
        temp2 += 1; 
    }
    
    | MOV SPACE B ',' A     { 
        fprintf(yyout, "0D\n");
        temp2 += 1; 
    }
    
    | MOV SPACE C ',' A     { 
        fprintf(yyout, "0E\n");
        temp2 += 1; 
    }
    
    | MOV SPACE C ',' B     { 
        fprintf(yyout, "0F\n");
        temp2 += 1; 
    }
    
    | INC SPACE A   { 
        fprintf(yyout, "10\n");
        temp2 += 1; 
    }
    
    | INC SPACE B   { 
        fprintf(yyout, "11\n");
        temp2 += 1; 
    }
    
    | INC SPACE C   { 
        fprintf(yyout, "12\n");
        temp2 += 1; 
    }
    
    | CMP SPACE A ',' NUMBER    { 
        fprintf(yyout, "13");
        char a, b;
        if($5 / 16 > 9)
            a = (char)($5 / 16 + 55);
        else
            a = (char)($5 / 16 + 48);
        if($5 % 16 > 9)
            b = (char)($5 % 16 + 55);
        else
            b = (char)($5 % 16 + 48);
        fprintf(yyout, "%c%c000000\n", a, b);
        temp2 += 5; 
    }
    
    | CMP SPACE A ',' ID    { 
        fprintf(yyout, "13");
        char a, b;
        int k = -1;
        for(int i = 0; i < ids; i++){
            if(!strcmp(symtab[i].id, $5)){
                k = i;
                break;
            }
        }
        if(k == -1)
            location = 255;
        else
            location = symtab[k].loc;
        if(location / 16 > 9)
            a = (char)(location / 16 + 55);
        else
            a = (char)(location / 16 + 48);
        if(location % 16 > 9)
            b = (char)(location % 16 + 55);
        else
            b = (char)(location % 16 + 48);
        fprintf(yyout, "%c%c000000\n", a, b);
        temp2 += 5; 
    }
    
    | CMP SPACE B ',' NUMBER    { 
        fprintf(yyout, "14");
        char a, b;
        if($5 / 16 > 9)
            a = (char)($5 / 16 + 55);
        else
            a = (char)($5 / 16 + 48);
        if($5 % 16 > 9)
            b = (char)($5 % 16 + 55);
        else
            b = (char)($5 % 16 + 48);
        fprintf(yyout, "%c%c000000\n", a, b);
        temp2 += 5; 
    }
    
    | CMP SPACE B ',' ID    { 
        fprintf(yyout, "14");
        char a, b;
        int k = -1;
        for(int i = 0; i < ids; i++){
            if(!strcmp(symtab[i].id, $5)){
                k = i;
                break;
            }
        }
        if(k == -1)
            location = 255;
        else
            location = symtab[k].loc;
        if(location / 16 > 9)
            a = (char)(location / 16 + 55);
        else
            a = (char)(location / 16 + 48);
        if(location % 16 > 9)
            b = (char)(location % 16 + 55);
        else
            b = (char)(location % 16 + 48);
        fprintf(yyout, "%c%c000000\n", a, b);
        temp2 += 5; 
    }
    
    | CMP SPACE C ',' NUMBER    { 
        fprintf(yyout, "15");
        char a, b;
        if($5 / 16 > 9)
            a = (char)($5 / 16 + 55);
        else
            a = (char)($5 / 16 + 48);
        if($5 % 16 > 9)
            b = (char)($5 % 16 + 55);
        else
            b = (char)($5 % 16 + 48);
        fprintf(yyout, "%c%c000000\n", a, b);
        temp2 += 5; 
    }
    
    | CMP SPACE C ',' ID    { 
        fprintf(yyout, "15");
        char a, b;
        int k = -1;
        for(int i = 0; i < ids; i++){
            if(!strcmp(symtab[i].id, $5)){
                k = i;
                break;
            }
        }
        if(k == -1)
            location = 255;
        else
            location = symtab[k].loc;
        if(location / 16 > 9)
            a = (char)(location / 16 + 55);
        else
            a = (char)(location / 16 + 48);
        if(location % 16 > 9)
            b = (char)(location % 16 + 55);
        else
            b = (char)(location % 16 + 48);
        fprintf(yyout, "%c%c000000\n", a, b);
        temp2 += 5; 
    }
    
    | ADDI SPACE ID     { 
        fprintf(yyout, "16");
        char a, b;
        int k = -1;
        for(int i = 0; i < ids; i++){
            if(!strcmp(symtab[i].id, $3)){
                k = i;
                break;
            }
        }
        if(k == -1)
            location = 255;
        else
            location = symtab[k].loc;
        if(location / 16 > 9)
            a = (char)(location / 16 + 55);
        else
            a = (char)(location / 16 + 48);
        if(location % 16 > 9)
            b = (char)(location % 16 + 55);
        else
            b = (char)(location % 16 + 48);
        fprintf(yyout, "%c%c000000\n", a, b);
        temp2 += 5; 
    }
    
    | ADDI SPACE NUMBER     { 
        fprintf(yyout, "16");
        char a, b;
        if($3 / 16 > 9)
            a = (char)($3 / 16 + 55);
        else
            a = (char)($3 / 16 + 48);
        if($3 % 16 > 9)
            b = (char)($3 % 16 + 55);
        else
            b = (char)($3 % 16 + 48);
        fprintf(yyout, "%c%c000000\n", a, b);
        temp2 += 5; 
    }
    
    | JE SPACE ID   { 
        fprintf(yyout, "17");
        char a, b;
        int k = -1;
        for(int i = 0; i < ids; i++){
            if(!strcmp(symtab[i].id, $3)){
                k = i;
                break;
            }
        }
        if(k == -1)
            location = 255;
        else
            location = symtab[k].loc;
        if(location / 16 > 9)
            a = (char)(location / 16 + 55);
        else
            a = (char)(location / 16 + 48);
        if(location % 16 > 9)
            b = (char)(location % 16 + 55);
        else
            b = (char)(location % 16 + 48);
        fprintf(yyout, "%c%c000000\n", a, b);
        temp2 += 5; 
    }
    
    | JMP SPACE ID  { 
        fprintf(yyout, "18");
        char a, b;
        int k = -1;
        for(int i = 0; i < ids; i++){
            if(!strcmp(symtab[i].id, $3)){
                k = i;
                break;
            }
        }
        if(k == -1)
            location = 255;
        else
            location = symtab[k].loc;
        if(location / 16 > 9)
            a = (char)(location / 16 + 55);
        else
            a = (char)(location / 16 + 48);
        if(location % 16 > 9)
            b = (char)(location % 16 + 55);
        else
            b = (char)(location % 16 + 48);
        fprintf(yyout, "%c%c000000\n", a, b);
        temp2 += 5; 
    }
    ;

number_list: NUMBER     { 
        char a, b;
        if($1 / 16 > 9)
            a = (char)($1 / 16 + 55);
        else
            a = (char)($1 / 16 + 48);
        if($1 % 16 > 9)
            b = (char)($1 % 16 + 55);
        else
            b = (char)($1 % 16 + 48);
        fprintf(yyout, "%c%c000000\n", a, b);
        temp += 4; 
    }
    | number_list ',' NUMBER    { 
        char a, b;
        if($3 / 16 > 9)
            a = (char)($3 / 16 + 55);
        else
            a = (char)($3 / 16 + 48);
        if($3 % 16 > 9)
            b = (char)($3 % 16 + 55);
        else
            b = (char)($3 % 16 + 48);
        fprintf(yyout, "%c%c000000\n", a, b);
        temp += 4; 
    }
    ;

%%

int yyerror(const char *s){
    fclose(yyin);
    fclose(yyout);
    yyout = fopen("machineCode.txt", "w");
    fprintf(yyout, "Error while parsing");
    fclose(yyout);
    printf("Syntax Error!!!!");
    exit(1);
}


int main(){
    // FILE *yyin;
    yyin = fopen("assemblyProgram.txt", "r");
    yyout = fopen("machineCode.txt", "w");
    if(yyin == NULL || yyout == NULL){
        printf("Error while opening files\n");
    }
    else{
        yyparse();
    }
    // for(int i = 0; i < ids; i++)
    //     printf("%s %d\n", symtab[i].id, symtab[i].loc);
    fprintf(yyout, "19\n");
    fclose(yyout);
    fclose(yyin);
    return 0;
}