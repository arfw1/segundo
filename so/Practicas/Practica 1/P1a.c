#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int main (int argc, char * argv[]){
	int x=atoi(argv[1]),y=atoi(argv[2]);
	int j;
	for(j=0;j<x;j++){
		if(fork()==0){
			printf("\nHijo con PID %d",getpid());
			break;
		}
	}
	if(j<x){
		for(int i=1;i<y;i++){
			if(fork()>0){
				printf("\nHas creado al Padre con PID %d",getpid());
				break;
			}
		}
	}

	printf("\nEsta acabando el programa\n");
	sleep(20);
	return 0;
}
