%{
	#include <stdio.h>
	#include <math.h>
	#include <stdlib.h>
	#include <string.h>
	#define PI 3.1416
    int Value[125];
	int i = 1 ;
	
%}

%token Plus Minus Multiply Divide Mod Sin Cos Tan Ln Fact
%token Number Print Equal ElseIf
%token Header_File Main_Function An_ID Integer_Type Float_Type Character_Type String_Type Return 
%token For_Loop Inc If Else lfb rfb lsb rsb ltb rtb 
%token smallerthan biggerthan smallorequal bigorequal EqualEqual

%left Equal
%left Plus Minus
%left Multiply Divide
%left Mod
%right Inc

%nonassoc If
%nonassoc Else
%nonassoc smallerthan biggerthan smallorequal bigorequal

%%
Input: 
	  | Input ST
	  ;
		
ST:   E 'sc'  		          { printf("\nExpresion Value: %d\t\n",$2); }
     | An_ID Equal E 'sc'     { Value[$1] = $3;  printf("\nValue of the statement: %d\n",$3);}
	 | If Cond E 'sc' %prec If{
								if($2){
									printf("\nExpresion Value: %d \n",$3);
								}
							}
	 | If Cond E 'sc' Else E 'sc' {
								if($2){
									printf("\nIf Expresion Value: : %d \n" , $3);
								}
								else{
									printf("\nElse Expresion Value: : %d \n",$6);
								}
							}
	 | If Cond E 'sc' ElseIf Cond E 'sc' Else E 'sc'{
                                if($2){
									printf("\nIf Expresion Value: : %d \n" , $3);
                                }
                                else if($6){
									printf("\nElse If Expresion Value: : %d \n" , $7);
                                }
								else{
									printf("\nElse Expresion Value: : %d \n",$10);
								}
							}	
	/*  | For_Loop ltb An_ID Equal E 'sc' E 'sc' E 'sc' rtb E{
                               int i = 0;
							   for(i = $3; $7 ; $9){
							       printf("\nValue of loop %d", i);
							   }
	 
							}	
     */					
     ;
	 
	 
Cond: 	ltb E rtb 		      { $$ = $2;}
		;
		
E:  Number                    
    | An_ID                   { $$ = Value[$1];}
    | E Plus E                { $$ = $1 + $3;}
	| E Minus E               { $$ = $1 - $3;}
	| E Multiply E            { $$ = $1 * $3;}
	| E Divide E              { $$ = $1 / $3;}
	| E Mod E                 { $$ = $1 % $3;}
	| E Fact		          {int f=1; 
	                           int i;
							   for(i=1; i<=$1; i++)
									f*= i;
							   $$= f;
							   }
	| Inc E                   { $$ = $2 + 1;}
	| E smallerthan E         { $$ = $1 < $3;}
	| E biggerthan E          { $$ = $1 > $3;}
	| E smallorequal E        { $$ = $1 <= $3;}
	| E bigorequal E          { $$ = $1 >= $3;}
	| Sin Cond                { printf("\nValue of sin :%lf\n", sin($2 * PI / 180.0)); }
    | Cos Cond	              { printf("\nValue of cos :%lf\n", cos($2 * PI / 180.0) ); }
    | Tan Cond	              { printf("\nValue of tan :%lf\n", tan($2 * PI / 180.0)); }
    | Ln Cond		          { printf("\nValue of ln :%lf\n", log($2)); }
    ;		
%%

yyerror(char *s) /* called by yyparse on error */
{
	printf("%s\n",s);
	return (0);
}
