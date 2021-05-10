// #include<bits/stdc++.h>
#include "next.h"

// using namespace std;
map<nodetype, string> startNodes{
  {eDATA,""},
  {eHTML,"\\documentclass{article}\n\\usepackage{hyperref}\n\\usepackage{comment}\n\\usepackage[utf8]{inputenc}\n\\usepackage[T1]{fontenc}\n\\usepackage{enumitem}\n\\usepackage{graphicx} "},
  {eHEAD,""},
  {eTITLE,"\n\\title{"},
  {eBODY,"\n\\begin{document}\n\\maketitle\n"},
  {eP,"\n\\par "},
  {eH1,"\\section{"},
  {eH2,"\\subsection{"},
  {eH3,"\\subsubsection{"},
  {eH4,"\\textbf{"},
  {eDIV,"\n"},
  {eCOMMENT,"\n\\begin{comment}\n"},
  {eCAPTION,"\\caption{"},
  {eCENTER,"\\begin{center} "},
  {eSUB,"_{"},
  {eSUP,"^{"},
  {eUL,"\n\\begin{itemize} "},
  {eLI,"\n\\item "},
  {eOL,"\n\\begin{enumerate} "},
  {eDL,"\n\\begin{description}[style=unboxed, labelwidth=\\linewidth, font =\\sffamily\\itshape\\bfseries, listparindent =0pt, before =\\sffamily]"},
  {eDT,"\\item["},
  {eDD,""},
  {eU,"\\underline{"},
  {eB,"\\textbf{"},
  {eI,"\\textit{"},
  {eEM,"\\emph{"},
  {eTT,"\\textt{"},
  {eSTRONG,"\\textbf{"},
  {eSMALL,"{\\fontsize{4}{5}\\selectfont "},
  {eFIGURE,""},
  {eFIGCAPTION,""},
  {eIMG,"\\includegraphics"},
  {eIMGSRC,""},
  {eIMGWIDTH,""},
  {eIMGHEIGHT,""},
  {eTR,"\n"},
  {eTH,""},
  {eTD,""},
  {eTRp,""},
  {eTHp," & "},
  {eTDp," & "},
  {eTABLE,"\n\\begin{table}[h!]\n"},
  {eTABLEBORDER,""},
  {eBREAK,"\\\\"},
  {eLINK,"\\href{"},
  {eAHREF,""},
  {eATITLE,""},
  {eANAME,""},
  {eFONT,"{\\fontsize{"},
  {eFONTSIZE,""},
  {econtent,""}
};

map<nodetype, string> endNodes{
  {eDATA,""},
  {eHTML,""},
  {eHEAD,""},
  {eTITLE,"} "},
  {eBODY,"\n\\end{document} "},
  {eP,""},
  {eH1,"} "},
  {eH2,"} "},
  {eH3,"} "},
  {eH4,"} "},
  {eDIV,""},
  {eCOMMENT,"\n\\end{comment}\n"},
  {eCAPTION,"} "},
  {eCENTER,"\n\\end{center} "},
  {eSUB,"} "},
  {eSUP,"} "},
  {eUL,"\n\\end{itemize} "},
  {eLI,""},
  {eOL,"\n\\end{enumerate} "},
  {eDL,"\\end{description} "},
  {eDT,"]"},
  {eDD,""},
  {eU,"} "},
  {eB,"} "},
  {eI,"} "},
  {eEM,"} "},
  {eTT,"} "},
  {eSTRONG,"} "},
  {eSMALL,"} "},
  {eFIGURE,""},
  {eFIGCAPTION,""},
  {eIMG,""},
  {eIMGSRC,""},
  {eIMGWIDTH,""},
  {eIMGHEIGHT,""},
  {eTR,"\\\\\n"},
  {eTH,""},
  {eTD,""},
  {eTRp," \\\\\n"},
  {eTHp,""},
  {eTDp,""},
  {eTABLE,"\n\\end{table}\\\\ "},
  {eTABLEBORDER,""},
  {eBREAK,""},
  {eLINK,"} "},
  {eAHREF,""},
  {eATITLE,""},
  {eANAME,""},
  {eFONT,"} "},
  {econtent,""}
};
ofstream latex ("latex.tex");					//	The file we now create will be this file

bool tb = true;									//	The variable taken as a flag to check if there will be the border in the table or not

/*
			`````````````````````````````````````````````````````````````````````````````````````````````````
			`	This is the function for making the intermediate node of some specific type like table etc.	`
			`````````````````````````````````````````````````````````````````````````````````````````````````
*/
treeNode* newnode(nodetype typ){
	treeNode* nodeAddr = new treeNode;
	nodeAddr->typ = typ;
	return nodeAddr;
}

/*
			`````````````````````````````````````````````````````````````````````````````````````````````````
			`						This function is for make the node of type DATA							`
			`````````````````````````````````````````````````````````````````````````````````````````````````
*/
treeNode* newnode(string data){
	treeNode* nodeAddr = new treeNode;
	nodeAddr->typ = eDATA;
	nodeAddr->data = data;
	return nodeAddr;
}

/*
			`````````````````````````````````````````````````````````````````````````````````````````````````
			`		This funtion is for making the terminal node of some type like TR or something			`
			`````````````````````````````````````````````````````````````````````````````````````````````````
*/
treeNode* newnode(string data, nodetype typ){
	treeNode* nodeAddr = new treeNode;
	nodeAddr->typ = typ;
	nodeAddr->data = data;
	return nodeAddr;
}

/*
			`````````````````````````````````````````````````````````````````````````````````````````````````
			`						This funtion is for adding the children to the node						`
			`````````````````````````````````````````````````````````````````````````````````````````````````
*/
void addchildren(treeNode* a, treeNode* b){
	a->children.push_back(b);
}

/*
			`````````````````````````````````````````````````````````````````````````````````````````````````
			`						This funtion is for adding the attributes of the node					`
			`````````````````````````````````````````````````````````````````````````````````````````````````
*/
void addattributes(treeNode* a, vector <treeNode*> b){
	a->children.insert((a->children).end(), b.begin(), b.end());
}

/*
			`````````````````````````````````````````````````````````````````````````````````````````````````
			`					This funtion is for traversing the every child of the node					`
			`````````````````````````````````````````````````````````````````````````````````````````````````
*/
void passchildren(treeNode *node) {
	for(vector<treeNode*>::iterator it = ((node->children).begin());it < ((node->children).end()); it++){
		makeDocument(*it);
	}
}

/*
			`````````````````````````````````````````````````````````````````````````````````````````````````
			`						This funtion is for seeing the image attributes							`
			`````````````````````````````````````````````````````````````````````````````````````````````````
*/
void seeImageAttribs(treeNode* node){
	string imgsrc, imgheight, imgwidth;
	for(vector<treeNode*>::iterator it = ((node->children).begin());it < ((node->children).end()); it++){
		if (((*it)->typ)==eIMGSRC) {
			imgsrc = (*it)->data;
		}else if (((*it)->typ)==eIMGHEIGHT) {
			imgheight = (*it)->data;
		}else if (((*it)->typ)==eIMGWIDTH) {
			imgwidth = (*it)->data;
		}else{
			continue;
		}
	}
	if(!(imgheight.empty()) && !(imgwidth.empty())){
		latex<<"[width = "<<imgwidth<<"px,imgheight = "<<imgheight<<"px]";
	}
	else if(!(imgheight.empty())){
		latex<<"[height = "<<imgheight<<"px]";
	}
	else if(!(imgwidth.empty())){
		latex<<"[width = "<<imgwidth<<"px]";
	}else{

	}
	latex<<"{"<<imgsrc<<"}";
}

/*
			`````````````````````````````````````````````````````````````````````````````````````````````````
			`						This funtion is for seeing the link attributes							`
			`````````````````````````````````````````````````````````````````````````````````````````````````
*/
void seeLinkAttribs(treeNode* node){
	for(vector<treeNode*>::iterator it = ((node->children).begin());it < ((node->children).end()); it++){
		if (((*it)->typ)==eAHREF){
			latex<<((*it)->data);
			break;
		}
		latex<<"}{";
	}
}

/*
			`````````````````````````````````````````````````````````````````````````````````````````````````
			`							This funtion is for setting the font size							`
			`````````````````````````````````````````````````````````````````````````````````````````````````
*/
void fontsizeprint(treeNode *node){
	int fontsiz;
	vector<treeNode*>::iterator it = ((node->children).begin());
	fontsiz = stoi((*it)->data);
	latex<<fontsiz<<"}{";
	fontsiz = fontsiz*1.2;
	latex<<fontsiz<<"}\\selectfont ";
}

/*
			`````````````````````````````````````````````````````````````````````````````````````````````````
			`							This funtion is for traversing the whole table						`
			`````````````````````````````````````````````````````````````````````````````````````````````````
*/
void seeTable(treeNode *node){
	vector<treeNode*>::iterator it = ((node->children).begin());
	int tableborder = stoi((*it)->data);
	it++;
	makeDocument(*it);
  latex<<"\n\\begin{tabular}";
	it++;
	it++;
	latex<<"{";
	if(tableborder>0){
		for(int i = 0; i < stoi((*it)->data); i++){
			latex<<"|c";
		}
		latex<<"|}\n";
	}else{
		for(int i = 0; i < stoi((*it)->data); i++){
			latex<<" c";
		}
		latex<<"}\n";
	}
	it++;
	makeDocument(*it);
  if(tableborder > 0) latex<<"\n\\hline";
	latex<<"\n\\end{tabular}";
	it++;
	makeDocument(*it);
	tb = true;
}

/*

*/
treeNode *leftchild(treeNode *node) {
	vector<treeNode*>::iterator it = ((node->children).begin());
	makeDocument(*it);
	it++;
	return *it;
}

/*

*/
int getdata(treeNode *node) {
	vector<treeNode*>::iterator it = ((node->children).begin());
	return ((*it)->typ);
}

/*

*/
void passchildrenSKIP1(treeNode *node) {
	vector<treeNode*>::iterator it = ((node->children).begin());
	it++;
	for(;it < ((node->children).end()); it++){
		makeDocument(*it);
	}
}

/*

*/
void makeDocument(treeNode *node){
	treeNode* it;
	switch (node->typ) {
		case eDATA:			latex<<(node->data);
							break;
		case eHTML: 		latex<<startNodes[eHTML];
							passchildren(node);
							latex<<endNodes[eHTML];
							break;
		case eHEAD:  		latex<<startNodes[eHEAD];
							passchildren(node);
							latex<<endNodes[eHEAD];
							break;
		case eTITLE:		latex<<startNodes[eTITLE];
							passchildren(node);
							latex<<endNodes[eTITLE];
							break;
		case econtent:		passchildren(node);
							break;
		case eBODY:			latex<<startNodes[eBODY];
							passchildren(node);
							latex<<endNodes[eBODY];
							break;
		case eP:			latex<<startNodes[eP];
							passchildren(node);
							latex<<endNodes[eP];
							break;
		case eH1:			latex<<startNodes[eH1];
							passchildren(node);
							latex<<endNodes[eH1];
							break;
		case eH2:			latex<<startNodes[eH2];
							passchildren(node);
							latex<<endNodes[eH2];
							break;
		case eH3:			latex<<startNodes[eH3];
							passchildren(node);
							latex<<endNodes[eH3];
							break;
		case eH4:			latex<<startNodes[eH4];
							passchildren(node);
							latex<<endNodes[eH4];
							break;
		case eDIV:			latex<<startNodes[eDIV];
							passchildren(node);
							latex<<endNodes[eDIV];
							break;
		case eCOMMENT:		latex<<startNodes[eCOMMENT];
							latex<<(node->data);
							latex<<endNodes[eCOMMENT];
							break;
		case eCAPTION:		latex<<startNodes[eCAPTION];
							passchildren(node);
							latex<<endNodes[eCAPTION];
							break;
		case eCENTER:		latex<<startNodes[eCENTER];
							passchildren(node);
							latex<<endNodes[eCENTER];
							break;
		case eSUB:			latex<<startNodes[eSUB];
							passchildren(node);
							latex<<endNodes[eSUB];
							break;
		case eSUP:			latex<<startNodes[eSUP];
							passchildren(node);
							latex<<endNodes[eSUP];
							break;
		case eUL:			latex<<startNodes[eUL];
							passchildren(node);
							latex<<endNodes[eUL];
							break;
		case eLI:			latex<<startNodes[eLI];
							passchildren(node);
							latex<<endNodes[eLI];
							break;
		case eOL:			latex<<startNodes[eOL];
							passchildren(node);
							latex<<endNodes[eOL];
							break;
		case eDL:			latex<<startNodes[eDL];
							passchildren(node);
							latex<<endNodes[eDL];
							break;
		case eDT:			latex<<startNodes[eDT];
							passchildren(node);
							latex<<endNodes[eDT];
							break;
		case eDD:			latex<<startNodes[eDD];
							passchildren(node);
							latex<<endNodes[eDD];
							break;
		case eU:			latex<<startNodes[eU];
							passchildren(node);
							latex<<endNodes[eU];
							break;
		case eB:			latex<<startNodes[eB];
							passchildren(node);
							latex<<endNodes[eB];
							break;
		case eI:			latex<<startNodes[eI];
							passchildren(node);
							latex<<endNodes[eI];
							break;
		case eEM:			latex<<startNodes[eEM];
							passchildren(node);
							latex<<endNodes[eEM];
							break;
		case eTT:			latex<<startNodes[eTT];
							passchildren(node);
							latex<<endNodes[eTT];
							break;
		case eSTRONG:		latex<<startNodes[eSTRONG];
							passchildren(node);
							latex<<endNodes[eSTRONG];
							break;
		case eSMALL:		latex<<startNodes[eSMALL];
							passchildren(node);
							latex<<endNodes[eSMALL];
							break;
		case eFIGURE:		latex<<startNodes[eFIGURE];
							passchildren(node);
							latex<<endNodes[eFIGURE];
							break;
		case eFIGCAPTION:	latex<<startNodes[eFIGCAPTION];
							passchildren(node);
							latex<<endNodes[eFIGCAPTION];
							break;
		case eIMG:			latex<<startNodes[eIMG];
							seeImageAttribs(node);
							latex<<endNodes[eIMG];
							break;
		case eTR:			latex<<startNodes[eTR];
							if(tb)
								latex<<"\n\\hline\n";
							passchildren(node);
							latex<<endNodes[eTR];
							break;
		case eTH:			latex<<startNodes[eTH];
							passchildren(node);
							latex<<endNodes[eTH];
							break;
		case eTD:			latex<<startNodes[eTD];
							passchildren(node);
							latex<<endNodes[eTD];
							break;
		case eTRp:			leftchild(node);
							if(tb)
								latex<<"\n\\hline\n";
							latex<<startNodes[eTRp];
							passchildrenSKIP1(node);
							latex<<endNodes[eTRp];
							break;
		case eTHp:			it = leftchild(node);
							latex<<startNodes[eTHp];
							passchildrenSKIP1(node);
							latex<<endNodes[eTHp];
							break;
		case eTDp:			it = leftchild(node);
							latex<<startNodes[eTDp];
							passchildrenSKIP1(node);
							latex<<endNodes[eTDp];
							break;
		case eTABLE:		latex<<startNodes[eTABLE];
							seeTable(node);
							latex<<endNodes[eTABLE];
							break;
		case eTABLEBORDER:	break;
		case eBREAK:		latex<<startNodes[eBREAK];
							break;
		case eLINK:			latex<<startNodes[eLINK];
							seeLinkAttribs(node);
							passchildren(node);
							latex<<endNodes[eLINK];
							break;
		case eAHREF:		break;
		case eATITLE:		break;
		case eANAME:		break;
		case eFONT:			latex<<startNodes[eFONT];
							fontsizeprint(node);
							passchildren(node);
							latex<<endNodes[eFONT];
							break;
		case eFONTSIZE:		break;
		default: 			break;
	}
}

/**************************************************************************************************************************************************************
								This function is used to traverse the whole tree and write the DATA written in it
***************************************************************************************************************************************************************/
void traverse(treeNode *node) {
  for(vector<treeNode*>::iterator it = ((node->children).begin());it < ((node->children).end()); it++){
		if (((*it)->typ)==eBREAK) {
			continue;
		}
    else if(!((*it)->typ)){
    	cout << ((*it)->data);
    }else{
    	traverse(*it);
    }
  }

}
