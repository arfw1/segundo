#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>

int pids[6];
char *letra;
char nodo;
void morir(){
	printf("soy %c (%d) y muero.\n",nodo,getpid());
	exit(1);
}

void matar(){
	 kill(pids[5],12);
	 kill(pids[4],12);
	 kill(pids[3],12);
}

void senialahijo(){
	switch(*letra){
		case'A':kill(pids[1],10);
			break;
		case'B':kill(pids[2],10);
			break;
		case'X':kill(pids[3],10);
			break;
		case'Y':kill(pids[4],10);
			break;
		default:break;


	}
}

void empezarLS(){
	printf("soy %s con pid(%d).\n",letra,getpid());
	if(fork()==0){
		execlp("ls","ls",NULL);
		exit(1);
	}else {
		wait();
		kill(pids[2],12);
	}
}
void empezarpstree(){
	printf("soy %s con pid(%d).\n",letra,getpid());
	if(fork()==0){
		execlp("pstree","pstree","-p",NULL);
		exit(1);
	}else {
		wait();
		kill(pids[2],12);
	}

}

int main(int argc, char *argv[]){
	int tiempo;
	letra=argv[1];
	tiempo=atoi(argv[2]);
	pid_t pidhijo;
	pids[0]=getpid();
	
	if(fork() == 0){
		nodo = 'A';
		pids[1] = getpid(); // Pid del abuelo
		printf("Soy el proceso A: mi pid es %d. Mi padre es %d\n", getpid(), getppid());
	
		if(fork() == 0){
			nodo = 'B';
			pids[2] = getpid(); // Pid del padre
			printf("Soy el proceso B: mi pid es %d. Mi padre es %d. Mi abuelo es %d\n", getpid(), getppid(), pids[0]);
			pidhijo = fork();
			pids[3] = pidhijo;

			if(pidhijo == 0){
				nodo = 'X';
				printf("Soy el proceso X: mi pid es %d. Mi padre es %d. Mi abuelo es %d. Mi bisabuelo es %d\n", getpid(), getppid(), pids[1], pids[0]);
			}else{
				pidhijo = fork();
				pids[4] = pidhijo;

				if(pidhijo == 0){
					nodo = 'Y';
					printf( "Soy el proceso Y: mi pid es %d. Mi padre es %d. Mi abuelo es %d. Mi bisabuelo es %d\n", getpid(), getppid(), pids[1], pids[0]);
					}else{
						pidhijo = fork();
						pids[5] = pidhijo;

						if(pidhijo == 0){
							nodo = 'Z';
							printf("Soy el proceso Z: mi pid es %d. Mi padre es %d. Mi abuelo es %d. Mi bisabuelo es %d\n", getpid(), getppid(), pids[1], pids[0]);
							signal(SIGALRM, senialahijo);
							alarm(tiempo);
							pause();
						}
					}
			}
		}
	}


	switch(nodo){
		case 'a':
		signal(SIGUSR2, SIG_IGN);

		wait();
		printf("Soy ejec(%d) y muero\n", getpid());
		exit(1);
		sleep(5);

		case 'A':
		signal(SIGUSR1, empezarpstree); 
		signal(SIGUSR2, SIG_IGN);

		wait();
		printf("Soy A(%d) y muero\n", getpid());
		exit(1);

		case 'B':

		signal(SIGUSR1, empezarpstree); 
		signal(SIGUSR2, matar);


		wait();
		wait();
		wait();
		printf("Soy B(%d) y muero\n", getpid());
		exit(1);

		case 'X':

		if(*letra == 'X'){
			signal(SIGUSR1, empezarLS); 
			pause();
		}

		signal(SIGUSR2, morir); 
		pause();

		case 'Y':

		if(*letra == 'Y'){
			signal(SIGUSR1, empezarLS); 
			pause();
		}

		signal(SIGUSR2, morir); 
		pause();

		case 'Z' :

		signal(SIGUSR2, morir);
		pause();
		}
	return 0;
}
		
	


	


