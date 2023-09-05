// Ficheros de cabecera
#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <stdlib.h>
 
int main(int argc, char *argv[])
{
 //Definir variables,estructuras
 struct sockaddr_in server;
 char ip[16];
 int fd, numbytes,puerto;
 char buf[1024];
 char enviar[1024];

 
 system("clear");
printf("La ip del servidor\n%s\n",argv[1]);

 puerto=9999;
printf("El puerto de conexion\n%d\n",puerto);
 
 //Socket
 if ((fd=socket(AF_INET, SOCK_STREAM, 0))==-1){
 printf("socket() error\n");
 exit(-1);
 }
 
 //Datos del servidor
 server.sin_family = AF_INET;
 server.sin_port = htons(puerto);
 server.sin_addr.s_addr=inet_addr(argv[1]);
 bzero(&(server.sin_zero),8);
 
//Conectarse al servidor
 if(connect(fd, (struct sockaddr *)&server,sizeof(struct sockaddr))==-1){
 printf("connect() error\n");
 exit(-1);
 }
 //Recibir mensaje de bienvenida
 if ((numbytes=recv(fd,buf,1024,0)) == -1){
 printf("Error en recv() \n");
 exit(-1);
 }
 printf("%s\n",buf);
//Ciclo para enviar y recibir mensajes
while(1){
 //El servidor espera el primer mensaje
 strcpy(enviar,argv[2]);
 printf("Escribir comando: %s",enviar);
 send(fd,enviar,1024,0);
 //El cliente recibe el mensaje del servidor
 recv(fd,buf,1024,0);
 printf("Servidor: %s\n",buf);
 break;
}
 recv(fd,buf,1024,0);
 printf("Servidor: %s\n",buf);
 close(fd);
}