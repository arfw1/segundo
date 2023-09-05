#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>


int shmid;
int *numero=NULL;

int creaComp(void){
  if((shmid=shmget(IPC_PRIVATE,sizeof(int),IPC_CREAT|0666))==-1){
    perror("Error al crear memoria compartida: ");
    return 1;
  }
  /* vinculamos el segmento de memoria compartida al proceso */
  numero=(int *) shmat (shmid,0,0);
  return 0;
}

void borraComp(void){
  char error[100];
  if (numero!=NULL){
    if (shmdt((char *)numero)<0){
      sprintf(error,"Pid %d: Error al desligar la memoria compartida: ",getpid());
      perror(error);
      exit(3);
    }
    if(shmctl(shmid,IPC_RMID,0)<0){
      sprintf(error,"Pid %d: Error al borrar memoria compartida: ",getpid());
      perror(error);
      exit(4);
    }
    numero=NULL;
  }
}

int main(int argc, char *argv[]){
  if(argc==3){
    creaComp();
    int x=atoi(argv[1]);
    int y=atoi(argv[2]);  
    int vector[x+1];
    int i=0,j=0,k=0;
    int pid_supremo=getpid();
    vector[0]=getpid();
    for(i=1;i<=x;i++){
      if(fork()>0){
        break;
      }
      else{
        vector[i]=getpid();
        if(i==x){
          for(j=1;j<=y;j++){
            if(fork()==0){
              printf("Soy el subhijo %d, mi padres son:",getpid());
              for(k=0;k<(x+1);k++){
                if(k==x){
                  printf(" %d\n",vector[k]);
                }
                else{ 
                  printf(" %d,",vector[k]);
                }
              } 
              numero[j-1]=getpid();
              break;
            }
          }
          sleep(5);
        }
      }
    }
    //wait(0);
    if(getpid()==pid_supremo){
      printf("Soy el superpadre (%d) : mis hijos finales son:",pid_supremo);
      sleep(5);
      for(i=0;i<y;i++){
        if(i==(y-1)){
          printf(" %d\n",numero[i]);
        }
        else{
          printf(" %d,",numero[i]);
        }
      }
    }
    else{ 
      exit(0);
    }
    borraComp();
  }
  else{ 
    write(1,"Error, argumentos incorrectos\n",30);
  }
}