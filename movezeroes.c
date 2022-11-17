#include <stdio.h>
#include <stdlib.h>

void moveZeroes(int* nums, int numsSize){
    int pre = 0, next, temp;
    for(next=0 ; next<numsSize ; next++){
        if(nums[next] != 0){
            temp = nums[next];
            nums[next] = nums[pre];
            nums[pre] = temp;
            pre++;
        }
    }
}

int main(){
	int array_size=0, i=0;
	int array[] = {1, 0, 0, 2, 5};
	moveZeroes(array, 5);
	for(i = 0 ;i < 5 ; i++){
		printf("%d ", array[i]);
	}
	return 0;
}
