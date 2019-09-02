#include <bits/stdc++.h>

using namespace std;

enum nodetype{
	eDATA, eHTML, eHEAD, eTITLE, eBODY,
	eP, eH1, eH2, eH3, eH4, eDIV, eCOMMENT, eCAPTION, eCENTER, eSUB, eSUP,
	eUL, eLI, eOL, eDL, eDT, eDD,
	eU, eB, eI, eEM, eTT, eSTRONG, eSMALL,
	eFIGURE, eFIGCAPTION, eIMG, eIMGSRC, eIMGWIDTH, eIMGHEIGHT,
	eTR, eTH, eTD, eTRp, eTHp, eTDp, eTABLE, eTABLEBORDER,
	eBREAK, eLINK, eAHREF, eATITLE, eANAME, eFONT, eFONTSIZE,
	econtent
};

typedef struct treeNode{
	nodetype typ;
	string data;
	vector <treeNode*> children;
}treeNode;

extern treeNode* newnode(nodetype typ);
extern treeNode* newnode(string data);
extern treeNode* newnode(string data, nodetype typ);
extern void addchildren(treeNode* a, treeNode* b);
extern void addattributes(treeNode* a, vector <treeNode*> b);
extern void traverse(treeNode *node);
extern void makeDocument(treeNode *node);
extern void passchildren(treeNode *node);
extern void seeImageAttribs(treeNode* node);
extern void seeLinkAttribs(treeNode* node);
extern void fontsizeprint(treeNode *node);
extern void passchildrenSKIP1(treeNode *node);
extern treeNode *leftchild(treeNode *node);
extern void seeTable(treeNode *node);

