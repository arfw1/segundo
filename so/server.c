#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <fcntl.h>
#include <sys/types.h> 
#include <sys/wait.h>
#define KTAM 256
#define KPUERTO 9999

/* SINCRONIZACION.
	1- el padre tiene un hijo y se queda esperando al hijo
	2- el hijo se queda esperando a que llegue una peticion
	3- el hijo atiende la peticion, acaba y le manda una señal al padre para que no espere mas
	4- el padre vuelve al punto 1.


	- el padre tendria que ser el que espera la conexion.
*/


int main(int argc, char *argv[]){
	socklen_t tam;
	struct sockaddr_in serverAddress, clientAddress;
   	int sock, newSock, fichOrigen;
	char buffer[KTAM];
	pid_t pid;

	sock = socket(AF_INET, SOCK_STREAM, 0);
	if (sock < 0) 
		perror("Error. No se pudo abrir el socket\n");
	else{
		bzero((char *) &serverAddress, sizeof(serverAddress));  // inicializa a 0 toda la estructura.
		serverAddress.sin_port = htons(KPUERTO);		// cambia el orden de los bytes para que se almacene
		serverAddress.sin_family = AF_INET;			//
		serverAddress.sin_addr.s_addr = INADDR_ANY;		// 	
		if(bind(sock, (struct sockaddr *) &serverAddress, sizeof(serverAddress)) < 0){ 
			perror("Error no se pudo vincular el socket\n");
		}
		else{
			listen(sock, 5);	// cola de peticiones hasta 5.
			do{
			
				printf("aceptando conexion\n");
				pid = fork(); 		// aqui creamos un hijo.
							// el padre no ejecuta el codigo y continua atendiendo peticiones.
				if(pid == 0){ 
					// este codigo de aqui lo ejecuta el hijo. 
					tam = sizeof(clientAddress);
					printf("hijo espera conexion\n");
					newSock = accept(sock, (struct sockaddr *) &clientAddress, &tam); // me quedo esperando a un cliente.
					printf("hijo acepta conexion\n");				
					if(newSock < 0){ 
						perror("error al aceptar la conexion");
					}
					else{
						// el hijo utiliza newSock para conectarse con el cliente.
						fichOrigen = open("Google.html", O_RDONLY);
						if(fichOrigen < 0){
							perror("error al abrir el fichero\n");			
						}					
						else{
							// TRANSMISION DEL FICHERO.
							do{
								tam = read(fichOrigen, buffer, KTAM - 1);			
								if(tam > 0){
									write(newSock, buffer, tam);
								}
							}while(tam > 0);
						}
						close(newSock);
						close(fichOrigen);
					}
				}
				else{
					printf("esperando al hijo\n");
					wait(NULL);
				}
			}while(1);
		
		}
	}	
	return 0; 
}
