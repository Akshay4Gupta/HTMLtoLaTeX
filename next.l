/*
---------------------------------------------------------------HERE THE GAME BEGINS---------------------------------------------------------------------------
-----------------------------------------------------------------BY AKSHAY GUPTA------------------------------------------------------------------------------
-------------------------------------------------------------------2019MCS2556--------------------------------------------------------------------------------
----------------------------------------------------------------------IITD------------------------------------------------------------------------------------
*/
%{
		#include "lexmod.cpp"
		#include "next.tab.h"
		void yyerror(char *);

%}

%option 									caseless
newline										[\n]+
spac										[ \t]+
punc    									[!?\.,:;@=/\'\"\*+\[\]\(\)]
word										({punc}|[a-zA-Z0-9])+
line										({word}|{spac})+
para										({line}|{newline})*
greek										&[A-Za-z0-9]+;
comment										<!--({para}|[<>])*-->
special										[_#$%&}{~^\\]

%x      									IMX
%x											TABLE
%x											A
%x											COM

%%
[ \n\t]+									;
{greek}										{
												if(checkGreek(yytext)){
													yylval.s = (char *)malloc(strlen(yytext)*sizeof(char));
													string x(yytext);
													string y =  GreekWords[x];
													strcpy(yylval.s,y.c_str());
												}else{
													yylval.s = (char *)malloc(strlen(yytext)*sizeof(char));
													string x = "\\";
													char * y = (char *)malloc((strlen(yytext)+2)*sizeof(char));
													strcpy(y,x.c_str());
													strcat(y,yytext);
													//printf("%s\n",y);
													strcpy(yylval.s,x.c_str());
													//free(y);
												}
												return DATA;
											}
{special}									{
												yylval.s = (char *)malloc(strlen(yytext)*sizeof(char));
												string x(yytext);
												if(x == "{")
													x = "\\{ ";
												else if(x == "}")
													x = "\\} ";
												else if(x == "$")
													x = "\\$ ";
												else if(x == "#")
													x = "\\# ";
												else if(x == "&")
													x = "\\& ";
												else if(x == "_")
													x = "\\_ ";
												else if(x == "%")
													x = "\\% ";
												else if(x == "~")
													x = "\\sim ";
												else if(x == "\\")
													x = "\\textbackslash ";
												else{
													x = "\\hat{} ";
												}
												strcpy(yylval.s,x.c_str());
												return DATA;
											}
"<!DOCTYPE"[^>]*">"							;
"<meta"[^>]*">"								;
"<html>"									{
												//printf("<html>");
												return S_HTML;
											}
"</html>"									{
												//printf("</html>");
												return E_HTML;
											}
"<head>"									{
												//printf("<head>");
												return S_HEAD;
											}
"</head>"									{
												//printf("</head>");
												return E_HEAD;
											}
"<body>"									{
												//printf("<body>");
												return S_BODY;
											}
"</body>"									{
												//printf("</body>");
												return E_BODY;
											}
"<title>"									{
												//printf("<title>");
												return S_TITLE;
											}
"</title>"									{
												//printf("</title>");
												return E_TITLE;
											}
"<p>"										{
												//printf("<p>");
												return S_P;
											}
"</p>"										{
												//printf("</p>");
												return E_P;
											}
"<center>"									{
												//printf("<center>");
												return S_CENTER;
											}
"</center>"									{
												//printf("</center>");
												return E_CENTER;
											}
"<h1>"										{
												//printf("<h1>");
												return S_H1;
											}
"</h1>"										{
												//printf("</h1>");
												return E_H1;
											}
"<h2>"										{
												//printf("<h2>");
												return S_H2;
											}
"</h2>"										{
												//printf("</h2>");
												return E_H2;
											}
"<h3>"										{
												//printf("<h3>");
												return S_H3;
											}
"</h3>"										{
												//printf("</h3>");
												return E_H3;
											}
"<h4>"										{
												//printf("</h4>");
												return S_H4;
											}
"</h4>"										{
												//printf("</h4>");
												return E_H4;
											}
"<div>"										{
												//printf("<div>");
												return S_DIV;
											}
"</div>"									{
												//printf("</div>");
												return E_DIV;
											}
"<sub>"										{
												//printf("<sub>");
												return S_SUB;
											}
"</sub>"									{
												//printf("</sub>");
												return E_SUB;
											}
"<sup>"										{
												//printf("<sup>");
												return S_SUP;
											}
"</sup>"									{
												//printf("</sup>");
												return E_SUP;
											}
"<ul>"										{
												//printf("<ul>");
												return S_UL;
											}
"</ul>"										{
												//printf("</ul>");
												return E_UL;
											}
"<li>"										{
												//printf("<li>");
												return S_LI;
											}
"</li>"										{
												//printf("</li>");
												return E_LI;
											}
"<ol>"										{
												//printf("<ol>");
												return S_OL;
											}
"</ol>"										{
												//printf("</ol>");
												return E_OL;
											}
"<dl>"										{
												//printf("<dl>");
												return S_DL;
											}
"</dl>"										{
												//printf("</dl>");
												return E_DL;
											}
"<dt>"										{
												//printf("<dt>");
												return S_DT;
											}
"</dt>"										{
												//printf("</dt>");
												return E_DT;
											}
"<dd>"										{
												//printf("<dd>");
												return S_DD;
											}
"</dd>"										{
												//printf("</dd>");
												return E_DD;
											}
"<table"[ ]*								{
												//printf("<table>");
												BEGIN TABLE;
												return S_TABLE;
											}
<TABLE>"border=\'"[0-9]+"\'"[ ]*			{
												char *s=(char *)malloc(strlen(yytext)*sizeof(char));
												strcpy(s,yytext);
												char a[2000];
												sscanf(yytext,"%*[^']'%[^']'",a);
												//printf("%s",a);
												yylval.s = (char * )malloc(strlen(yytext)*sizeof(char));
												strcpy(yylval.s,a);
												//free(s);
												//BEGIN IMX;
												return TABLEBORDER;
											}
<TABLE>"border=\""[0-9]+"\""[ ]*			{
												char *s=(char *)malloc(strlen(yytext)*sizeof(char));
												strcpy(s,yytext);
												char a[2000];
												sscanf(yytext,"%*[^\"]\"%[^\"]\"",a);
												//printf("%s",a);
												yylval.s = (char * )malloc(strlen(yytext)*sizeof(char));
												strcpy(yylval.s,a);
												//free(s);
												//BEGIN IMX;
												return TABLEBORDER;
											}
<TABLE>[ ]*">"								{
												BEGIN 0;
											}
"</table>"									{
												//printf("</table>");
												return E_TABLE;
											}
"<u>"										{
												//printf("<u>");
												return S_U;
											}
"</u>"										{
												//printf("</u>");
												return E_U;
											}
"<b>"										{
												//printf("<b>");
												return S_B;
											}
"</b>"										{
												//printf("</b>");
												return E_B;
											}
"<i>"										{
												//printf("<i>");
												return S_I;
											}
"</i>"										{
												//printf("</i>");
												return E_I;
											}
"<em>"										{
												//printf("<em>");
												return S_EM;
											}
"</em>"										{
												//printf("</em>");
												return E_EM;
											}
"<tt>"										{
												//printf("<tt>");
												return S_TT;
											}
"</tt>"										{
												//printf("</tt>");
												return E_TT;
											}
"<strong>"									{
												//printf("<strong>");
												return S_STRONG;
											}
"</strong>"									{
												//printf("</strong>");
												return E_STRONG;
											}
"<small>"									{
												//printf("<small>");
												return S_SMALL;
											}
"</small>"									{
												//printf("</small>");
												return E_SMALL;
											}
"<caption>"									{
												//printf("<caption>");
												return S_CAPTION;
											}
"</caption>"								{
												//printf("</caption>");
												return E_CAPTION;
											}
"<tr>"										{
												//printf("<tr>");
												return S_TR;
											}
"</tr>"										{
												//printf("</tr>");
												return E_TR;
											}
"<th>"										{
												//printf("<th>");
												return S_TH;
											}
"</th>"										{
												//printf("</th>");
												return E_TH;
											}
"<td>"										{
												//printf("<td>");
												return S_TD;
											}
"</td>"										{
												//printf("</td>");
												return E_TD;
											}
"<br"[ ]*[/]?">"							{
												//printf("<br>");
												return BREAK;
											}
"<a"[ ]+									{
												BEGIN A;
												return S_LINK;
											}
<A>"href=\'"[a-zA-Z0-9\.#=_:/%]+"\'"[ ]*	{
												char *s=(char *)malloc(strlen(yytext)*sizeof(char));
												strcpy(s,yytext);
												char a[2000];
												sscanf(yytext,"%*[^']'%[^']'",a);
												//printf("%s",a);
												yylval.s = (char * )malloc(strlen(yytext)*sizeof(char));
												strcpy(yylval.s,a);
												//free(s);
												//BEGIN IMX;
												return AHREF;
											}
<A>"href=\""[a-zA-Z0-9\.#=_:/%]+"\""[ ]*	{
												char *s=(char *)malloc(strlen(yytext)*sizeof(char));
												strcpy(s,yytext);
												char a[2000];
												sscanf(yytext,"%*[^\"]\"%[^\"]\"",a);
												//printf("%s",a);
												yylval.s = (char * )malloc(strlen(yytext)*sizeof(char));
												strcpy(yylval.s,a);
												//free(s);
												//BEGIN IMX;
												return AHREF;
											}
<A>"title=\""[a-zA-Z0-9\./]+"\""[ ]*		{
												char *s=(char *)malloc(strlen(yytext)*sizeof(char));
												strcpy(s,yytext);
												char a[2000];
												sscanf(yytext,"%*[^\"]\"%[^\"]\"",a);
												//printf("%s",a);
												yylval.s = (char * )malloc(strlen(yytext)*sizeof(char));
												strcpy(yylval.s,a);
												//free(s);
												//BEGIN IMX;
												return ATITLE;
											}
<A>"title=\'"[a-zA-Z0-9\./]+"\'"[ ]*		{
												char *s=(char *)malloc(strlen(yytext)*sizeof(char));
												strcpy(s,yytext);
												char a[2000];
												sscanf(yytext,"%*[^']'%[^']'",a);
												//printf("%s",a);
												yylval.s = (char * )malloc(strlen(yytext)*sizeof(char));
												strcpy(yylval.s,a);
												//free(s);
												//BEGIN IMX;
												return ATITLE;
											}
<A>"name=\'"[a-zA-Z0-9\./]+"\'"[ ]*			{
												char *s=(char *)malloc(strlen(yytext)*sizeof(char));
												strcpy(s,yytext);
												char a[2000];
												sscanf(yytext,"%*[^']'%[^']'",a);
												//printf("%s",a);
												yylval.s = (char * )malloc(strlen(yytext)*sizeof(char));
												strcpy(yylval.s,a);
												//free(s);
												//BEGIN IMX;
												return ANAME;
											}
<A>"name=\""[a-zA-Z0-9\./]+"\""[ ]*			{
												char *s=(char *)malloc(strlen(yytext)*sizeof(char));
												strcpy(s,yytext);
												char a[2000];
												sscanf(yytext,"%*[^\"]\"%[^\"]\"",a);
												//printf("%s",a);
												yylval.s = (char * )malloc(strlen(yytext)*sizeof(char));
												strcpy(yylval.s,a);
												//free(s);
												//BEGIN IMX;
												return ANAME;
											}
<A>[ ]*">"									{
												BEGIN 0;
											}
"</a>"										{
												//printf("</a>");
												return E_LINK;
											}
"<font"[^>]+">"								{
												char a[2000];
												sscanf(yytext,"%*[^']'%[^']'",a);
												//printf("%s",a);
												yylval.s = (char * )malloc(strlen(yytext)*sizeof(char));
												strcpy(yylval.s,a);
												return S_FONT;
											}
"</font>"									{
												//printf("</font>");
												return E_FONT;
											}
"<figure>"									{
												//printf("</figure>");
												return S_FIGURE;
											}
"</figure>"									{
												//printf("</figure>");
												return E_FIGURE;
											}
"<figcaption>"								{
												//printf("<figcaption>");
												return S_FIGCAPTION;
											}
"</figcaption>"								{
												//printf("</figcaption>");
												return E_FIGCAPTION;
											}
"<img"[ ]+									{
												BEGIN IMX;
												return IMG;
											}
<IMX>"src=\'"[a-zA-Z0-9\.#=_:/%]+"\'"[ ]*	{
												char *s=(char *)malloc(strlen(yytext)*sizeof(char));
												strcpy(s,yytext);
												char a[2000];
//												printf("\n:::::::::::::src checking::::::::::::::::\n");
												sscanf(yytext,"%*[^']'%[^']'",a);
												//printf("%s\n", yytext);
												//printf("%s",a);
												yylval.s = (char * )malloc(strlen(yytext)*sizeof(char));
												strcpy(yylval.s,a);
												//free(s);
												//BEGIN IMX;
												return IMGSRC;
										}
<IMX>"src=\""[a-zA-Z0-9\.#=_:/%]+"\""[ ]*	{
												char *s=(char *)malloc(strlen(yytext)*sizeof(char));
												strcpy(s,yytext);
												char a[2000];
//												printf("\n:::::::::::::src checking::::::::::::::::\n");
												sscanf(yytext,"%*[^\"]\"%[^\"]\"",a);
												//printf("%s",a);
												yylval.s = (char * )malloc(strlen(yytext)*sizeof(char));
												strcpy(yylval.s,a);
												//free(s);
												//BEGIN IMX;
												return IMGSRC;
											}
<IMX>"width=\'"[0-9%]+"\'"[ ]*				{
												char *s=(char *)malloc(strlen(yytext)*sizeof(char));
												strcpy(s,yytext);
												char a[2000];
			//										printf("\n::::::::::width checking:::::::::::\n");
												sscanf(yytext,"%*[^']'%[^']'",a);
												//printf("%s",a);
												yylval.s = (char * )malloc(strlen(yytext)*sizeof(char));
												strcpy(yylval.s,a);
												//free(s);
												//BEGIN IMX;
												return IMGWIDTH;
											}
<IMX>"width=\""[0-9%]+"\""[ ]*				{
												char *s=(char *)malloc(strlen(yytext)*sizeof(char));
												strcpy(s,yytext);
												char a[2000];
		//										printf("\n::::::::::width checking:::::::::::\n");
												sscanf(yytext,"%*[^\"]\"%[^\"]\"",a);
												//printf("%s",a);
												yylval.s = (char * )malloc(strlen(yytext)*sizeof(char));
												strcpy(yylval.s,a);
												//free(s);
												//BEGIN IMX;
												return IMGWIDTH;
											}
<IMX>"height=\'"[0-9%]+"\'"[ ]*				{
												char *s=(char *)malloc(strlen(yytext)*sizeof(char));
												strcpy(s,yytext);
												char a[2000];
												sscanf(yytext,"%*[^']'%[^']'",a);
												//printf("%s",a);
												yylval.s = (char * )malloc(strlen(yytext)*sizeof(char));
												strcpy(yylval.s,a);
												//free(s);
												//BEGIN IMX;
												return IMGHEIGHT;
											}
<IMX>"height=\""[0-9%]+"\""[ ]*				{
												char *s=(char *)malloc(strlen(yytext)*sizeof(char));
												strcpy(s,yytext);
												char a[2000];
												sscanf(yytext,"%*[^\"]\"%[^\"]\"",a);
												//printf("%s",a);
												yylval.s = (char * )malloc(strlen(yytext)*sizeof(char));
												strcpy(yylval.s,a);
												//free(s);
												//BEGIN IMX;
												return IMGHEIGHT;
											}
<IMX>[ ]*[ /]?">"							{
												BEGIN 0;
											}
{para}										{
												yylval.s = (char * )malloc(strlen(yytext)*sizeof(char));
												strcpy(yylval.s, yytext);
												return DATA;
											}
"<!--"										{
												BEGIN COM;
											}
<COM>({para}|[<>])*?						{
												yylval.s = (char * )malloc(sizeof(yytext)*sizeof(char));
												strcpy(yylval.s, yytext);
												return COMMENT;
											}
<COM>"-"({para}|[<>])*						{
												yylval.s = (char * )malloc(sizeof(yytext)*sizeof(char));
												strcpy(yylval.s, yytext);
												return COMMENT;
											}
<COM>"--"({para}|[<])*						{
												yylval.s = (char * )malloc(sizeof(yytext)*sizeof(char));
												strcpy(yylval.s, yytext);
												return COMMENT;
											}
<COM>{special}								{
												yylval.s = (char *)malloc(strlen(yytext)*sizeof(char));
												string x(yytext);
												if(x == "{")
													x = "\\{ ";
												else if(x == "}")
													x = "\\} ";
												else if(x == "$")
													x = "\\$ ";
												else if(x == "#")
													x = "\\# ";
												else if(x == "&")
													x = "\\& ";
												else if(x == "_")
													x = "\\_ ";
												else if(x == "%")
													x = "\\% ";
												else if(x == "~")
													x = "\\sim ";
												else if(x == "\\")
													x = "\\textbackslash ";
												else
													x = "\\hat{} ";
												strcpy(yylval.s,x.c_str());
												return COMMENT;
											}
<COM>"-->"									{
												BEGIN 0;
											}

%%
int yywrap(void) {
	return 1;
}
