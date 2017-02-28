%{
	#include <stdio.h>
	#include <string.h>
	#include <stdlib.h>
	#include "bison.tab.h"
%}


%%
[a-z]+".h"                 {return Header_File;}

[A-Za-z]                  { yylval = *yytext;return An_ID;}

[$][$][' '][A-Z' 'a-z0-9]+ {printf("A single line comment\n");printf("%s\n",yytext);}

[$][*][' '][A-Z' 'a-z]+[*][$] {printf("Multi line comment\n");printf("%s\n",yytext);}

switch                   {return Switch;}

case                     {return Case;}

int                      {return Integer_Type;}

float                    {return Float_Type;}

string                   {return String_Type;}

char                     {return Character_Type;}

core                     {return Main_Function;}

[0-9]+                   {yylval = atoi(yytext); return Number;}

cm                       {return *yytext;}

sc                       {return *yytext;}

iff                      {return If ;}

or                       {return Else ;}

oriff                    {return ElseIf;}

loopf                    {return For_Loop;}

smaller                  {return smallerthan;}

bigger                   {return biggerthan;}

smallorequal             {return smallorequal;}

bigorequal               {return bigorequal;}

back                     {return Return;}

lsb                      {return lsb;}

rsb                      {return rsb;}

lfb                      {return lfb;}

rfb                      {return rfb;}

ltb                      {return ltb;}

rtb                      {return rtb;}

sum                      {return Plus ;}

sub                      {return Minus; }

mul                      {return Multiply ; }

div                      {return Divide ; }

mod                      {return Mod ;}

inc                      {return Inc;}

cos			             {return Cos; }

sin 			         {return Sin ;}

tan 		             {return Tan ; }

ln			             {return Ln ; }

[:]                      {return Equal ;}

[,]				  		 {return *yytext;}

[:][:]                   {return EqualEqual ;}

print                    {return Print; }
 
[ \t\n]

%%

int yywrap()
{
   return 1;
}

int main()
{
   yyin = freopen(".txt","r",stdin);
   yyout = freopen("output31.txt","w",stdout);
   yyparse();
   return 0;
}
