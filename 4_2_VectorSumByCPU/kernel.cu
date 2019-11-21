#include <iostream>
#include "../anLogger/src/anlogger.h"
#include <thread>
#define N	79872

void add(int *a, int *b, int *c) {
	int tid = 0;	// this is CPU zero, so we start at zero
	while (tid < N) {
		c[tid] = a[tid] + b[tid];
		tid += 1;	// we have one CPU, so we increment by one
	}
}

//void add(int *a, int *b, int *c) {
//	for (int i = 0; i < N; i++) {
//		c[i] = a[i] + b[i];
//	}
//}


int main(void) {

	int a[N], b[N], c[N];
	double start, end;
	int coreCount = std::thread::hardware_concurrency();

	for (int j = 1; j < 10; ++j) {
		// fill the arrays 'a' and 'b' on the CPU
		for (int i = 0; i < N; i++) {
			a[i] = -i;
			b[i] = i * i;
		}
		start = __anElapsedTimeNSEC__;
		add(a, b, c);
		end = __anElapsedTimeNSEC__;
	}

	// display the results
	//for (int i = 0; i<N; i++) {
	//	printf("%d + %d = %d\n", a[i], b[i], c[i]);
	//}

	printf("Vector sumed by %d-core CPU consumes %lf ns.\n", coreCount,(end-start)/ coreCount);

	system("pause");
	return 0;
}
