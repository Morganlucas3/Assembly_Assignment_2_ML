
// TODO: Your code 

#include <vector>
#include <algorithm>
using namespace std;

extern "C" void reverse(signed long*, long);

void reverse(signed long* a, long b){


	
	//make a long vector
	vector<long> v;
	
	//make a long variable call it temp
	long temp;
	
	for(int i = 0; i < b; i++){
	temp = *a;
	v.push_back(temp);
	a++;
	}
		
	reverse(v.begin(), v.end());
	

	for(int i = 0; i < b; i++){
	a--;
	}
	
	for (long i: v){
	*a = i;
	a++;
	}

}
