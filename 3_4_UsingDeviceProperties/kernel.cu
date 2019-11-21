#include <iostream>

static void HandleError(cudaError_t err,
	const char *file,
	int line) {
	if (err != cudaSuccess) {
		printf("%s in %s at line %d\n", cudaGetErrorString(err),
			file, line);
		exit(EXIT_FAILURE);
	}
}
#define HANDLE_ERROR( err ) (HandleError( err, __FILE__, __LINE__ ))

int main(void) {
	cudaDeviceProp	prop; int dev;

	HANDLE_ERROR(cudaGetDevice(&dev));
	printf("ID of current CUDA device:	%d\n", dev);


	memset(&prop, 0, sizeof(cudaDeviceProp)); 
	prop.major = 6;
	prop.minor = 1;
	HANDLE_ERROR(cudaChooseDevice(&dev, &prop));
	printf("ID of CUDA device closest to revision 6.1: %d\n", dev); HANDLE_ERROR(cudaSetDevice(dev));

	system("pause");
	return 0;
}
