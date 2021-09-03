%{
#include <stdio.h>
#include "y.tab.h"

void buildNumber(char* yytext, int yyleng);
char _buffer[42];
%}


Number [1-9][0-9]*

%%
`
"+"	{return '+';}
"-"	{return '-';}
"*"	{return '*';}
"/"	{return '/';}
"("	{return '(';}
")"	{return ')';}

{Number}	{ buildNumber(yytext,yyleng); yylval.sval = strdup(_buffer); return NUMBER;}


%%

void numberString (char number,char * buffer){
    switch (number) {
        case '0' : sprintf(buffer,"Zer");
            break;
        case '1' : sprintf(buffer,"One");
            break;
        case '2' : sprintf(buffer,"Two");
            break;
        case '3' : sprintf(buffer,"Thr");
            break;
        case '4' : sprintf(buffer,"Fou");
            break;
        case '5' : sprintf(buffer,"Fiv");
            break;
        case '6' : sprintf(buffer,"Six");
            break;
        case '7' : sprintf(buffer,"Sev");
            break;
        case '8' : sprintf(buffer,"Eig");
            break;
        case '9' : sprintf(buffer,"Nin");
            break;
    }
}

void buildNumber(char * yytext , int yyleng) {
    char buffer_temp[4];
    char buffer_5[7];
    char buffer_4[7];
    char buffer_3[4];
    char buffer_sub1[23];
    char buffer_2[7];
    char buffer_1[7];
    char buffer_0[4];

    for (int i = 0; i < yyleng; i++) {

        switch (yyleng - i - 1) {

            case 0:
                numberString(yytext[i],buffer_temp);
                sprintf(buffer_0,"%s",buffer_temp);
                if (yyleng==3){
                    sprintf(_buffer,"%s_%s_%s",buffer_2,buffer_1,buffer_0);
                }
                else if (yyleng==2){
                    sprintf(_buffer,"%s_%s",buffer_1,buffer_0);
                }
                else if (yyleng==1) {
                    sprintf(_buffer,"%s",buffer_0);
                }
                else{
                    sprintf(_buffer,"%s_%s_%s_%s",buffer_sub1,buffer_2,buffer_1,buffer_0);
                }

                break;

            case 1:
                numberString(yytext[i],buffer_temp);
                sprintf(buffer_1,"%sTen",buffer_temp);
                break;

            case 2:
                numberString(yytext[i],buffer_temp);
                sprintf(buffer_2,"%sHun",buffer_temp);
                break;

            case 3:
                numberString(yytext[i],buffer_temp);
                sprintf(buffer_3,"%s",buffer_temp);
                if (yyleng==6){
                    sprintf(buffer_sub1,"(%s_%s_%s)Tou",buffer_5,buffer_4,buffer_3);
                }
                else if (yyleng==5){
                    sprintf(buffer_sub1,"(%s_%s)Tou",buffer_4,buffer_3);
                }
                else if (yyleng==4){
                    sprintf(buffer_sub1,"(%s)Tou",buffer_3);
                }
                break;

            case 4:
                numberString(yytext[i],buffer_temp);
                sprintf(buffer_4,"%sTen",buffer_temp);
                break;

            case 5:
                numberString(yytext[i],buffer_temp);
                sprintf(buffer_5,"%sHun",buffer_temp);
                break;
        }
    }
}

int yywrap (void) {return 1;}
