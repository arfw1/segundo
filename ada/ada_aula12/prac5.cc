#include <iostream>
#include <cmath>
using namespace std;

unsigned long pasos2_1 , pasos2_2, pasos2_3,pasos2_4;
//lineal exponencial y logarítmica
unsigned long pow2_1(unsigned n){
    pasos2_1++;
    if (n == 0){
        return 1;
    }else{
        return 2 * pow2_1(n-1);
    }
}

unsigned long pow2_2(unsigned n){
    pasos2_2++;
    if (n == 0){
        return 1;
    }else{
        return pow2_2(n-1) + pow2_2(n -1);
    }
}

unsigned long pow2_3(unsigned n){
    pasos2_3++;
    if (n == 0){
        return 1;
    }else{
        unsigned long r = pow2_3(n/2);
        r=r*r;
        if(n%2 ==1){
            r*=2;
        }
        return r;
    }
}

unsigned long pow2_4(unsigned n){
    pasos2_4++;
    if (n == 0){
        return 1;
    }else{
        if(n%2==0){
            return 2 * pow2_4(n/2)*pow2_4(n/2);
        }else{
            return pow2_4(n/2)*pow2_4(n/2);
        }
    }
}


En el main que hay foto en el movil añadir despues de inicializar los pasos __has_cpp_attribute
res=pow(2,n);
r2_1= pow2_1(n);
r2_2=pow2_2(n);
r2_3=pow2_3(n);

if(res!=r2_1 || res!=r2_2 || res!=r3_3){
    throw "ERROR. CÁLCULO REALIZADO INCORRECTAMENTE";
}

