#include "lexmod.h"

bool checkGreek(string s){
	if(GreekWords.count(s)>0){
		return true;
	}else{
		return false;
	}
}
