#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>
#include <fcntl.h>
#include <stdlib.h>
#include <string.h>

#define SIZE 512

int main (int argc, char *argv[]){

    FILE *f = fopen(argv[1], "r");
    FILE *f2 = fopen(argv[2], "w");

    if(f==NULL||f2==NULL){//comprueba si ambos ficheros se han abierto correctament
        perror ("Error al abrir los ficheros");
        return -1;
    }

    //creamos procesos padre e hijo y la tuberia
    pid_t pid;
    int p[2], readbytes, status;
    char buffer[SIZE];
    pipe(p);
    pid=fork();

    if(pid==0){//entra el hijo
        close(p[1]);//cierra escribir y lee
        //********
        while((readbytes=read(p[0],buffer,SIZE))>0){
            fwrite(buffer, sizeof(char), strlen(buffer), f2);
        }
        close(p[0]);
    }else{//entra el padre
        close(p[0]);//cierra leer y escribe
        //lee y manda a la tubería cada linea
        while (fgets(buffer, SIZE, f) != NULL){
          if(strlen(buffer)<SIZE){
            char cadena[strlen(buffer)+1];
            strcpy(cadena,buffer);
            write(p[1],cadena,strlen(cadena));
          }else{
             write(p[1],buffer,strlen(buffer));
          }
        }
        close(p[1]);
        sleep(5);
    }
}
