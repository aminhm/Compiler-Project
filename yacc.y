%{ 
#include <stdio.h>
void yyerror(char *);

int yylex();
int count=1;
%}
%union {
	char* sval;
}
%start expr_p
%token <sval> NUMBER
%left '+' '-'
%left '*' '/'
%type<sval> expr_p expr term fact

%%

expr_p : expr		 { if(count==1){printf("Assign %s to t%d\n",$1,count);printf("Print t%d\n",count);}else printf ( "Print %s\n",$1 ); }


expr :  expr '+' term    { printf  ( "Assign %s Plu %s to t%d\n" , $1 , $3 , count );char buffer[6]; sprintf(buffer,"t%d",count);count++; $$ = buffer ;}
|       expr '-' term	 { printf  ( "Assign %s Min %s to t%d\n" , $1 , $3 , count );char buffer[6]; sprintf(buffer,"t%d",count);count++; $$ = buffer ;}
|       term		 { $$ = $1; }
;
term :  term '*' fact	 { printf ( "Assign %s Mul %s to t%d\n" , $1 , $3 , count );char buffer[6]; sprintf(buffer,"t%d",count);count++; $$ = buffer ;}
|       term '/' fact	 { printf ( "Assign %s Div %s to t%d\n" , $1 , $3 , count );char buffer[6]; sprintf(buffer,"t%d",count);count++; $$ = buffer ;}
|       fact		 { $$ = $1; }
;
fact :  '('  expr  ')'	 { $$ = $2; }
|       NUMBER		 { $$ = $1; }
;

%%

void yyerror(char * s){
	fprintf(stderr, "%s\n" , s);
}

int main(void){
	yyparse();
	return 0;
}
