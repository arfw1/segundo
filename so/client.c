#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <netinet/in.h>
#include <netdb.h> 
#include <string.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#define KTAM 512
#define KPUERTO 9999

int main(int argc, char *argv[]){
    char buffer[KTAM];
    int sock, tam, puerto;
    struct sockaddr_in serv_addr;
    struct hostent *server;

    sock = socket(AF_INET, SOCK_STREAM, 0);
    if (sock < 0) 
        perror("Error. No se pudo crear socket");
	else{
	    bzero((char *) &serv_addr, sizeof(serv_addr));
		serv_addr.sin_port = htons(KPUERTO);
		serv_addr.sin_family = AF_INET;
		serv_addr.sin_addr.s_addr = inet_addr(argv[1]);
		if (connect(sock ,(struct sockaddr *) &serv_addr,sizeof(serv_addr)) < 0){ 
		    perror("Error. No se pudo conectar al socket");
		}
		else{
			do{
				tam = read(sock, buffer, KTAM -1);
				if(tam > 0){
					buffer[tam] = '\0';
				printf("%s",buffer);
				}		    
			}while(tam > 0);
			close(sock);
		}
	}
    return 0;
}
