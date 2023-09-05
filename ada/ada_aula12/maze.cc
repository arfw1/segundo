//Adam Roy Frederick William Reading Y2483358Q
#include <iostream>
#include <vector>
#include <limits>
using namespace std;

struct Data{
    vector<vector<int>> maze;
    int filas;
    int columnas;
}

bool gestionArgumentos(int argc,char *argv[],bool &t,bool &p, bool &ignore, string &nombre_Fichero){
    t=false;
    p=false;
    ignore=false;
    for (int i=1 i<argc; i++){
        string arg =argv[i];
        if(arg=="-t"){
            t=true;
        }else{
            if(arg=="-p"){
                p=true;
            }else{
                if(arg=="--ignore-naive"){
                    ignore=true;
                }else{
                    if(arg=="-f"){
                        if(i+1<argc){
                            nombre_Fichero = argv[i+1];
                            i++;
                            if(nombre_Fichero=""){
                                cerr << "Usage:" <<  endl << "maze [-p] [-t] [--ignore-naive] -f file" << endl;
                            }
                        }else{
                            cerr<<"Error: missing filename"<<endl;
                            cerr << "Usage:" <<  endl << "maze [-p] [-t] [--ignore-naive] -f file" << endl;
                            return false;
                        }
                    }else{
                        cerr<<"Error: unknown option"<< endl;
                        cerr << "Usage:" <<  endl << "maze [-p] [-t] [--ignore-naive] -f file" << endl;
                        return false;
                    }

                }
            }      
        }
    }

}

bool leerFichero(Data data, string nombre_fichero){
	bool leido = false;
	ifstream fichero;
	int valor;
	fichero.open(nombre_fichero.c_str());
	if(fich.is_open()){
		leido = true;
		fichero >> data.filas >> data.columnas;
		for(int i = 0; i < dp.filas; i++){
			vector<int> fila;			
			for(int j = 0; j < dp.columnas; j++){
				fichero >> valor;
				fila.push_back(valor);
			}
			data.maze.push_back(fila);
		}
		fichero.close();
	}
	else{
		cerr << "ERROR: cannot open file " << nombre_fichero << endl;
		cerr << "Usage:" <<  endl << "maze [-p] [-t] [--ignore-naive] -f file" << endl;	
	}
	return leido;
}

int  maze_naive (int i, int j,Data &data){
    int resultado, celda1,celda2,celda3;
    if(data.maze[i][j]==0){
        resultado=numeric_limits<int>::max();
    }else{
        if(i==0 & j==0){
            return 1;
        }else{
            if(i>0 && j>0){
                celda1=maze_naive(i-1,j-1,data);
            }else{
                if(i>0){
                    celda2=maze_naive(i-1,j,data);
                }else{
                    celda2=numeric_limits<int>::max();
                }

                if(j>0){
                   celda3=maze_naive(i,j-1,data);
                }else{
                    celda3=numeric_limits<int>::max();
                }

                if(celda1 != numeric_limits<int>::max() || celda2 != numeric_limits<int>::max() || celda3 != numeric_limits<int>::max()){
                    if (celda1 <= celda2 && celda1 <= celda3 ){
                        return celda1+1;
                    }else{
                        if(celda1>=celda2 && celda2<=celda3){
                            return celda1+1;
                        }else{
                            return celda2+1;
                        }
                    }
                }else{
                    return numeric_limits<int>::max();
                }
            }
        }
    }
}

 int  maze_memo(int i,int j, Data &data,vector<vector<int>> &memorizadas){
     int resultado, celda1,celda2,celda3;
     if(memorizadas[i][j]!=-1){
        return memorizadas[i][j];
     }else{
        if(data.maze[i][j]==0){
            thundercats[i][j]=numeric_limits<int>::max();
        }else{
             if(i>0 && j>0){
                celda1=memo(i-1,j-1,data,memorizadas);
            }else{
                if(i>0){
                    celda2=memo(i-1,j,data,memorizadas);
                }else{
                    celda2=numeric_limits<int>::max();
                }

                if(j>0){
                   celda3=memo(i,j-1,data,memorizadas);
                }else{
                    celda3=numeric_limits<int>::max();
                }

                if(celda1 != numeric_limits<int>::max() || celda2 != numeric_limits<int>::max() || celda3 != numeric_limits<int>::max()){
                    if (celda1 <= celda2 && celda1 <= celda3 ){
                        memorizadas[i][j]= celda1+1;
                        return memorizadas[i][j];
                        
                    }else{
                        if(celda1>=celda2 && celda2<=celda3){
                           memorizadas[i][j]= celda1+1;
                           return memorizadas[i][j];
                        }else{
                            memorizadas[i][j]= celda2+1;
                            return memorizadas[i][j];
                        }
                    }
                }else{
                    memorizadas[i][j]= numeric_limits<int>::max();
                    return memorizadas[i][j];
                }
            }
        }
     }
 }

int main(int argc, char *argv[]){
    Data data;
    bool okArgs,t,p,ignore,leido;
    string nombre_fichero;
    if(gestionArgumentos(argc,argv,t,p,ignore,nombre_fichero)){
        if(leerFichero(data,nombre_fichero)){
            vector<vector<int>> memorizadas(dp.filas, vector<int>(dp.columnas, -1))
        }
        for(vector<int> fila:data.maze){
            for(int numFila:fila){
                cout<<numFila<<" ";
            }
            cout<<endl;
        }
        if(ignore){
            cout<<"- ";
        }else{
            cout<<maze_naive(data.filas-1,data.columnas-1,data)<<" ";
        }
        cout<<maze_memo(data.filas-1,data.columnas-1,data,memorizadas)<<" ";
        if(p){
            
			for(auto fila : memorizadas){
				for(auto elemento : fila){
					cout.width(2);
					if(elemento == -1){
						cout << "? ";
					}
					else{
						if(elemento == numeric_limits<int>::max()){
							cout << "? ";
						}
						else{
							cout <<"? ";
						}
					}
				}
				cout << endl;
			}
        }
    	if(t){
			cout << "Memoization table" << endl;
			for(auto fila : memorizadas){
				for(auto elemento : fila){
					cout.width(2);
					if(elemento == -1){
						cout << "- ";
					}
					else{
						if(elemento == numeric_limits<int>::max()){
							cout << "X ";
						}
						else{
							cout << elemento << " ";
						}
					}
				}
				cout << endl;
			}
		}   
    }
    return 0;
}