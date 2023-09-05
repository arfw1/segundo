#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <signal.h>

void alarma(){
	//tiene que ejecutar una funcion exec
	//hay que crear un hijo porque si no se carga a z
	if(fork()==0){
		execlp("pstree","-c | grep P1b",NULL);
	}
}
//OTRA OPCION
/* void ejecuta_pstree(){
	system(pstree);
}*/
int main (int argc, char * argv[]){
	int t=atoi(argv[1]),i,j,pidpadre,pidabuelo,pidbisabuelo;
	//kill(a quien (PID),tipo de señal (sigalarm...)
	printf("\nSoy el proceso ejec: mi pid es %d",getpid());
	pidpadre=getpid();	
	for(i=0;i<3;i++){
		if(fork()>0){
			if(i==0){
				printf("\nSoy el proceso A: mi pid es %d. Mi padre es %d",getpid(),pidpadre);
				pidabuelo=pidpadre;
				pidpadre=getpid();
			}else if(i==1){
				printf("\nSoy el proceso B: mi pid es %d. Mi padre es %d. Mi abuelo es %d",getpid(),pidpadre,pidabuelo);
				pidbisabuelo=pidabuelo;
				pidabuelo=pidpadre;
				pidpadre=getpid();
			}else if(i==2){
				printf("\nSoy el proceso X: mi pid es %d. Mi padre es %d. Mi abuelo es %d.Mi bisabuelo es %d",getpid(),pidpadre,pidabuelo,pidbisabuelo);
			}
			
			break;
		}
	}
	if(i==2){
		for(j=0;j<3;j++){
			if(fork()==0){
				printf("Bb\n");
				break;
			}
		}
	}
	/*if(j==3){
		signal(SIGALRM,alarma);
		alarm(t); //Se envia a si mismo una señal de alarma en 3s y ejecuta alarma
		pause();
	}*/
	sleep(t);
}
