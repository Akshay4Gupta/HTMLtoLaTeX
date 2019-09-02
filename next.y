/*
---------------------------------------------------------------HERE THE GAME BEGINS---------------------------------------------------------------------------
-----------------------------------------------------------------BY AKSHAY GYPTA------------------------------------------------------------------------------
-------------------------------------------------------------------2019MCS2556--------------------------------------------------------------------------------
----------------------------------------------------------------------IITD------------------------------------------------------------------------------------
*/

%{
#include<bits/stdc++.h>
#include "next.h"
using namespace std;

void yyerror(string);
int yylex(void);
int rowscount = 0, columncount = 0;
extern FILE *yyin;
vector <treeNode*> a_atrib, img_atrib;
vector <treeNode*> root;
 
%}

%union				{
						char *s;
						struct treeNode* tree;
					}

%start	estart
%token	<tree>	S_HTML E_HTML 		
%token	<s>		METADATA	 		S_HEAD E_HEAD 		S_BODY E_BODY		S_TITLE E_TITLE
%token	<s>		S_H1 E_H1			S_H2 E_H2 			S_H3 E_H3 			S_H4 E_H4			S_CAPTION E_CAPTION
%token	<s>		S_CENTER E_CENTER 	S_P E_P 			S_DIV E_DIV 		S_SUB E_SUB 		S_SUP E_SUP
%token	<s>		S_UL E_UL 			S_LI E_LI 			S_OL E_OL 			S_DL E_DL 			S_DT E_DT 		S_DD E_DD
%token	<s>		S_U E_U				S_B E_B 			S_I E_I 			S_EM E_EM 			S_TT E_TT
%token	<s>		S_STRONG E_STRONG 	S_SMALL E_SMALL		S_FIGURE E_FIGURE	S_FIGCAPTION E_FIGCAPTION	IMG
%token	<s>		S_TR E_TR 			S_TH E_TH 			S_TD E_TD 			S_TABLE E_TABLE			TABLEBORDER
%token	<s>		BREAK				META				E_LINK E_FONT		AHREF ATITLE ANAME		DOCTYPE			COMMENT
%token	<s>		DATA				S_LINK				S_FONT 				IMGSRC IMGWIDTH IMGHEIGHT

%type	<s>			tableborder	atag_attrib	imgattr

%type	<tree>		estart		head		body		title		
%type	<tree>		para		content		data		bodytags
%type	<tree>		head1		head2		head3		head4		div			sup			sub			underline	italics		bold
%type	<tree>		teletype	strong		small		atag		font		center		break		ul			ol			list		dl				dd
%type	<tree>		dlist		caption		figure		figcaption	table		rows		columns		img			emphasize		



%%

estart:			S_HTML head body E_HTML					{
															$$ = newnode(eHTML);
															//addchildren($$,newnode("S_HTML\n"));
															addchildren($$,$2);
															addchildren($$,$3);
															makeDocument($$);
														};
/*-----------------------------------------------------------------------------HEAD---------------------------------------------------------------------------------------*/
head:			S_HEAD title E_HEAD 					{
															$$ = newnode(eHEAD);
															//addchildren($$,newnode("S_HEAD\n"));
															addchildren($$,$2);
															//addchildren($$,newnode("E_HEAD\n"));
														}
|														{
															$$ = newnode("");
														};
title:			S_TITLE content E_TITLE					{
															$$ = newnode(eTITLE);
															//addchildren($$,newnode("S_TITLE\n"));
															addchildren($$,$2);
															//addchildren($$,newnode("E_TITLE\n"));
														}
|														{
															$$ = newnode("");
														};
/*-----------------------------------------------------------------------------BODY---------------------------------------------------------------------------------------------------*/
body:			S_BODY content E_BODY					{
															$$ = newnode(eBODY);
															//addchildren($$,newnode("S_BODY\n"));
															addchildren($$,$2);
															//addchildren($$,newnode("E_BODY\n"));
														}
|														{
															$$ = newnode("");
														};
content:		content bodytags						{
															$$ = newnode(econtent);
															addchildren($$,$1);
															addchildren($$,$2);
														}
|														{
															$$ = newnode("");
														};
/*--------------------------------------------------------------------------TEXT DATA-------------------------------------------------------------------------------------------------*/
bodytags:		ul										{
															$$ = $1;
														}
|				ol										{
															$$ = $1;
														}
|				dl										{
															$$ = $1;
														}
|				figure									{
															$$ = $1;
														}
|				figcaption								{
															$$ = $1;
														}
|				img										{
															$$ = $1;
														}
|				table									{
															$$ = $1;
														}
|				head1									{
															$$ = $1;
														}
|				head2									{
															$$ = $1;
														}
|				head3									{
															$$ = $1;
														}
|				head4									{
															$$ = $1;
														}
|				para									{
															$$ = $1;
														}
|				atag									{
															$$ = $1;
														}
|				div										{
															$$ = $1;
														}
|				sup										{
															$$ = $1;
														}
|				sub										{
															$$ = $1;
														}
|				underline								{
															$$ = $1;
														}
|				italics									{
															$$ = $1;
														}
|				bold									{
															$$ = $1;
														}
|				emphasize								{
															$$ = $1;
														}
|				teletype								{
															$$ = $1;
														}
|				strong									{
															$$ = $1;
														}
|				small									{
															$$ = $1;
														}
|				font									{
															$$ = $1;
														}
|				center									{
															$$ = $1;
														}
|				break									{
															$$ = $1;
														}
|				list									{
															$$ = $1;
														}
|				dlist									{
															$$ = $1;
														}
|				dd										{
															$$ = $1;
														}
|				data									{
															$$ = $1;
														};
/*--------------------------------------------------------------------------TEXT DATA-----------------------------------------------------------------------------------------------*/
para:			S_P content E_P							{
															$$ = newnode(eP);
															//addchildren($$,newnode("S_P\n"));
															addchildren($$,$2);
															//addchildren($$,newnode("E_P\n"));
														};
data:			DATA									{
															$$ = newnode($1);
														}
|				COMMENT									{
															$$ = newnode($1,eCOMMENT);
														};
		
head1:			S_H1 content E_H1						{
															$$ = newnode(eH1);
															//addchildren($$,newnode("S_H1\n"));
															addchildren($$,$2);
															//addchildren($$,newnode("E_H1\n"));
														};
head2:			S_H2 content E_H2						{
															$$ = newnode(eH2);
															//addchildren($$,newnode("S_H2\n"));
															addchildren($$,$2);
															//addchildren($$,newnode("E_H2\n"));
														};
head3:			S_H3 content E_H3						{
															$$ = newnode(eH3);
															//addchildren($$,newnode("S_H3\n"));
															addchildren($$,$2);
															//addchildren($$,newnode("E_H3\n"));
														};
head4:			S_H4 content E_H4						{
															$$ = newnode(eH4);
															//addchildren($$,newnode("S_H4\n"));
															addchildren($$,$2);
															//addchildren($$,newnode("E_H4\n"));
														};
div:			S_DIV content E_DIV						{
															$$ = newnode(eDIV);
															//addchildren($$,newnode("S_DIV\n"));
															addchildren($$,$2);
															//addchildren($$,newnode("E_DIV\n"));
														};
sup:			S_SUP data E_SUP						{
															$$ = newnode(eSUP);
															//addchildren($$,newnode("S_SUP\n"));
															addchildren($$,$2);
															//addchildren($$,newnode("E_SUP\n"));
														};
sub:			S_SUB data E_SUB						{
															$$ = newnode(eSUB);
															//addchildren($$,newnode("S_SUB\n"));
															addchildren($$,$2);
															//addchildren($$,newnode("E_SUB\n"));
														};
underline:		S_U content E_U							{
															$$ = newnode(eU);
															//addchildren($$,newnode("S_U\n"));
															addchildren($$,$2);
															//addchildren($$,newnode("E_U\n"));
														};
italics:		S_I content E_I							{
															$$ = newnode(eI);
															//addchildren($$,newnode("S_I\n"));
															addchildren($$,$2);
															//addchildren($$,newnode("E_I\n"));
														};
bold:			S_B content E_B							{
															$$ = newnode(eB);
															//addchildren($$,newnode("S_B\n"));
															addchildren($$,$2);
															//addchildren($$,newnode("E_B\n"));
														};
emphasize:		S_EM content E_EM						{
															$$ = newnode(eEM);
															//addchildren($$,newnode("S_EM\n"));
															addchildren($$,$2);
															//addchildren($$,newnode("E_EM\n"));
														};
teletype:		S_TT content E_TT						{
															$$ = newnode(eTT);
															//addchildren($$,newnode("S_TT\n"));
															addchildren($$,$2);
															//addchildren($$,newnode("E_TT\n"));
														};
strong:			S_STRONG content E_STRONG				{
															$$ = newnode(eSTRONG);
															//addchildren($$,newnode("S_STRONG\n"));
															addchildren($$,$2);
															//addchildren($$,newnode("E_STRONG\n"));
														};
small:			S_SMALL content E_SMALL					{
															$$ = newnode(eSMALL);
															//addchildren($$,newnode("S_SMALL\n"));
															addchildren($$,$2);
															//addchildren($$,newnode("E_SMALL\n"));
														};
atag:			S_LINK atag_attrib content E_LINK		{
															$$ = newnode(eLINK);
															//addchildren($$,newnode("S_LINK\n"));
															addattributes($$,a_atrib);
															addchildren($$,$3);
															//addchildren($$,newnode("E_LINK\n"));
															a_atrib.clear();
														};
atag_attrib:	atag_attrib AHREF						{
															a_atrib.push_back(newnode($2, eAHREF));
															$$ = (char *)"";
														}
|				atag_attrib ATITLE						{
															a_atrib.push_back(newnode($2, eATITLE));
															$$ = (char *)"";
															
														}
|				atag_attrib ANAME						{
															a_atrib.push_back(newnode($2, eANAME));
															$$ = (char *)"";
															
														}
|														{
															$$ = (char *)"";
														};
font:			S_FONT content E_FONT					{
															$$ = newnode(eFONT);
															//addchildren($$,newnode("S_FONT\n"));
															addchildren($$,newnode($1,eFONTSIZE));
															addchildren($$,$2);
															//addchildren($$,newnode("E_FONT\n"));
														};
center:			S_CENTER content E_CENTER				{
															$$ = newnode(eCENTER);
															//addchildren($$,newnode("S_CENTER\n"));
															addchildren($$,$2);
															//addchildren($$,newnode("E_CENTER\n"));
														};
break:      	BREAK									{
															$$ = newnode(eBREAK);
														};
/*-----------------------------------------------------------------------------list-----------------------------------------------------------------------------------*/
ul:				S_UL content E_UL						{
															$$ = newnode(eUL);
															//addchildren($$,newnode("S_UL\n"));
															addchildren($$,$2);
															//addchildren($$,newnode("E_UL\n"));
														};
ol:				S_OL content E_OL						{
															$$ = newnode(eOL);
															//addchildren($$,newnode("S_OL\n"));
															addchildren($$,$2);
															//addchildren($$,newnode("E_OL\n"));
														};
list:			S_LI content E_LI						{
															$$ = newnode(eLI);
															//addchildren($$,newnode("S_LI\n"));
															addchildren($$,$2);
															//addchildren($$,newnode("E_LI\n"));
														};
dl:				S_DL content E_DL						{
															$$ = newnode(eDL);
															//addchildren($$,newnode("S_DL\n"));
															addchildren($$,$2);
															//addchildren($$,newnode("E_DL\n"));
														};
dlist:			S_DT content E_DT						{
															$$ = newnode(eDT);
															//addchildren($$,newnode("S_DT\n"));
															addchildren($$,$2);
															//addchildren($$,newnode("E_DT\n"));
														};
dd:			 	S_DD content E_DD						{
															$$ = newnode(eDD);
															//addchildren($$,newnode("S_DD\n"));
															addchildren($$,$2);
															//addchildren($$,newnode("E_DD\n"));
														};
/*---------------------------------------------------------------------------figure-----------------------------------------------------------------------------------*/
figure:			S_FIGURE content E_FIGURE				{
															$$ = newnode(eFIGURE);
															//addchildren($$,newnode("S_FIGURE\n"));
															addchildren($$,$2);
															//addchildren($$,newnode("E_FIGURE\n"));
														};
figcaption: 	S_FIGCAPTION content E_FIGCAPTION		{
															$$ = newnode(eFIGCAPTION);
															//addchildren($$,newnode("S_FIGCAPTION\n"));
															addchildren($$,$2);
															//addchildren($$,newnode("E_FIGCAPTION\n"));
														};
img:			IMG imgattr								{
															$$ = newnode(eIMG);
															//addchildren($$,newnode("S_IMG\n"));
															addattributes($$,img_atrib);
															//addchildren($$,newnode("E_IMG\n"));
															img_atrib.clear();
														};
imgattr:		imgattr IMGSRC							{
															img_atrib.push_back(newnode($2, eIMGSRC));
															$$ = (char *)"";
															
														}
|				imgattr IMGWIDTH						{
															img_atrib.push_back(newnode($2,eIMGWIDTH));
															$$ = (char *)"";
															
														}
|				imgattr IMGHEIGHT						{
															img_atrib.push_back(newnode($2,eIMGHEIGHT));
															$$ = (char *)"";
															
														}
|														{
															$$ = (char *)"";
															
														};
/*----------------------------------------------------------------------------Table-----------------------------------------------------------------------------------*/
table:			S_TABLE tableborder caption rows caption E_TABLE{
															$$ = newnode(eTABLE);
															//addchildren($$,newnode("S_TABLE\n"));
															addchildren($$,newnode($2,eTABLEBORDER));
															addchildren($$,$3);
															addchildren($$,newnode(to_string(rowscount)));
															addchildren($$,newnode(to_string(columncount/rowscount)));
															addchildren($$,$4);
															addchildren($$,$5);
															//addchildren($$,newnode("E_TABLE\n"));
															rowscount = 0;
															columncount = 0;
														};
tableborder:	TABLEBORDER								{
															$$ = $1;
														}
|														{
															$$ = (char *)"0";
														};
caption:		S_CAPTION content E_CAPTION				{
															$$ = newnode(eCAPTION);
															//addchildren($$,newnode("S_CAPTION\n"));
															addchildren($$,$2);
															//addchildren($$,newnode("E_CAPTION\n"));
														}
|														{
															$$ = newnode("");
														};
rows:			rows S_TR columns E_TR 					{
															$$ = newnode(eTRp);
															addchildren($$,$1);
															//addchildren($$,newnode("S_TR\n"));
															addchildren($$,$3);
															//addchildren($$,newnode("E_TR\n"));
															rowscount++;
														}
|				S_TR columns E_TR						{
															$$ = newnode(eTR);
															//addchildren($$,newnode("S_TR\n"));
															addchildren($$,$2);
															//addchildren($$,newnode("E_TR\n"));
															rowscount++;
														};
columns:		columns S_TH content E_TH 				{
															$$ = newnode(eTHp);
															addchildren($$,$1);
															//addchildren($$,newnode("S_TH\n"));
															addchildren($$,$3);
															//addchildren($$,newnode("E_TH\n"));
															columncount++;
														}
|				columns S_TD content E_TD 				{
															$$ = newnode(eTDp);
															addchildren($$,$1);
															//addchildren($$,newnode("S_TD\n"));
															addchildren($$,$3);
															//addchildren($$,newnode("E_TD\n"));
															columncount++;
														}
|				S_TH content E_TH						{
															$$ = newnode(eTH);
															//addchildren($$,newnode("S_TH\n"));
															addchildren($$,$2);
															//addchildren($$,newnode("E_TH\n"));
															columncount++;
														}
|				S_TD content E_TD						{
															$$ = newnode(eTD);
															//addchildren($$,newnode("S_TD\n"));
															addchildren($$,$2);
															//addchildren($$,newnode("E_TD\n"));
															columncount++;
														};
%%
void yyerror(string s){
	cout<<s;
}
int main(int argc, char *argv[]){
	yyin = fopen(argv[1], "r");
	yyparse();

	return 0;
}
