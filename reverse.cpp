
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
	
	//make a for loop (int i = 0; i < b; i++) {
	//temp = ptr
	//vector.push_back(temp)
	// ptr++
	//}
	
	for(int i = 0; i < b; i++){
	temp = a*;
	v.push_back(temp);
	a++;
	}
		
	reverse(v.begin(), v.end());
	
	//for loop to move ptr (int i = 0; i < b; i--){
	//ptr--
	//}

	for(int i = 0; i < b; i--){
	a--;
	}
	
	for (long i: v){
	*a = i;
	a++;
	}

}
