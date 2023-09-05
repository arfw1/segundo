func maxOpt(_ x:Int?, _ y :Int?)->Int?{
  if let a=x , let b=y{
    if a>b{
      return a
    }else{
      return b
    }
  }else if let a=x{
    return a
  }else{
    return y
  }
}/*
let res1 = maxOpt(nil, nil) 
let res2 = maxOpt(10, nil)
let res3 = maxOpt(-10, 30)
print("res1 = \(String(describing: res1))")
print("res2 = \(String(describing: res2))")
print("res3 = \(String(describing: res3))")
// Imprime:
// res1 = nil
// res2 = Optional(10)
// res3 = Optional(30)*/

func parejaMayorParImpar2(numeros:[Int])->(Int?, Int?){
  
  if numeros.isEmpty{
    return (nil,nil)
  }else{
    let primero = numeros[0]
    let resto = Array(numeros.dropFirst())
    if primero%2==0{
      if let par = parejaMayorParImpar2(numeros: resto).1{
        if primero > par{
          return ( parejaMayorParImpar2(numeros:resto).0,primero)
        }else{
          return ( parejaMayorParImpar2(numeros:resto).0,par)
        }
      }
      return(parejaMayorParImpar2(numeros:resto).0,primero)
    }else{
       if let impar = parejaMayorParImpar2(numeros: resto).0{
        if primero > impar{
          return (primero,parejaMayorParImpar2(numeros:resto).1)
        }else{
          return (impar,parejaMayorParImpar2(numeros:resto).1)
        }
      }else{
        return (nil,parejaMayorParImpar2(numeros:resto).1)
      }
    }
  }
}
/*
let numeros = [-10, 202, 12, 100, 204, 2]
print("\n******\n1b1) Función parejaMayorParImpar2(numeros:)\n******")
print(parejaMayorParImpar2(numeros: numeros))
// Imprime:
// parejaMayorParImpar2(numeros: [-10, 202, 12, 100, 204, 2])
// (nil, Optional(204))*/

func sumaMaxParesImpares(numeros:[Int])->Int{
  var impar_final=0
  var par_final=0
  if numeros.isEmpty{
    return 0
  }else{
    if let impar = parejaMayorParImpar2(numeros:numeros).0{
      impar_final=impar
    }
    if let par = parejaMayorParImpar2(numeros:numeros).1{
      par_final=par
    }
    return par_final+impar_final;
  }
}
/*
let numeros = [-10, 202, 12, 100, 204, 2]
print("sumaMaxParesImpares(numeros: \(numeros))")
print(sumaMaxParesImpares(numeros: numeros))
// Imprime:
// sumaMaxParesImpares(numeros: [-10, 202, 12, 100, 204, 2])
// 204*/


//EJERCICIO 2
//a.1 3
// a.2 215
//a.3 [2 2 2 2 5 6]
//a.4 [(En,2) (un,2) (de,2) (la,2) (lugar,5) (mancha,6)]

//b.1 cuenta el numero de veces que aparece n en un array de enteros f(nums:[2,3,4,5,2,3,2], n:2)->3

//b.2 elimina los elementos repetidos de una lista. g(nums:[2,3,4,5,2])->[2,3,4,5]
//b.3 devuelve una pareja de arrays donde el array izquierdo contiene numeros menor que n y el derecho tiene numeros mayores o iguales. h(nums:[1,7,5,4,6,3,2],4)->([1,4,3,2],[7,5,6])

func suma(palabras:[String],contienen:Character)->Int{
  return palabras.reduce(0,{
    (res:Int,palabra:String)-> Int in
                                    if palabra.contains(contienen){
                                      return res+palabra.count
                                    }else{
                                      return res
                                    }
  })
}

func sumaMenoresMayores(nums:[Int],pivote:Int) -> (Int,Int){
  nums.reduce((0,0),{
    (res:(Int,Int) , num:Int) -> (Int,Int) in
      if num < pivote {
        return (res.0 + num , res.1)
      }else{
        return (res.0 , res.1+num)
      }
  })
}

//EJERCICIO 3
/*
indirect enum Arbol<T> {
  case nodo(T,[Arbol<T>])
}

func toArray<T>(arbol: Arbol<T>)->{
  switch arbol{
    case let .nodo(dato,resto):
      return [dato] + toArrayBosque(arbol:resto)
    case .vacio:
      return []
  }
}

func toArrayBosque<T>(arbol:Arbol<T>){
  let primero   
}
let arbolInt: Arbol = .nodo(53, 
                            [.nodo(13, []), 
                             .nodo(32, []), 
                             .nodo(41, 
                                   [.nodo(36, []), 
                                    .nodo(39, [])
                                   ])
                            ])

*/
//Ejercicio 4
import Foundation
func imprimirListadoAlumnos(_ alumnos: [(String, Double, Double, Double, Int)]) {
    print("Alumno   Parcial1   Parcial2   Parcial3  Años")
    for alu in alumnos {
        alu.0.withCString {
            print(String(format:"%-10s %5.2f      %5.2f    %5.2f  %3d", $0, alu.1,alu.2,alu.3,alu.4))
        }
    }
}

let listaAlumnos = [("Pepe", 8.45, 3.75, 6.05, 1), 
                    ("Maria", 9.1, 7.5, 8.18, 1), 
                    ("Jose", 8.0, 6.65, 7.96, 1),
                    ("Carmen", 6.25, 1.2, 5.41, 2), 
                    ("Felipe", 5.65, 0.25, 3.16, 3), 
                    ("Carla", 6.25, 1.25, 4.23, 2), 
                    ("Luis", 6.75, 0.25, 4.63, 2), 
                    ("Loli", 3.0, 1.25, 2.19, 3)]
func imprimeListadosNotas(alumnos:[(String,Double,Double,Double,Int)]){
  print("\n array ordenado por nombre del alumno (orden alfabético creciente)\n")
  imprimirListadoAlumnos(alumnos.sorted(by:{$0.0 < $1.0}))
  print("\n array ordenado por la nota del parcial 1 (orden decreciente de nota)\n")
  imprimirListadoAlumnos(alumnos.sorted(by:{$0.1 > $1.1}))
  print("\n array ordenado por la nota del parcial 2 (orden creciente de nota)\n")
  imprimirListadoAlumnos(alumnos.sorted(by:{$0.2 < $1.2}))
  print("\n array ordenado por año de matriculación y nota del parcial 3 (orden decreciente de año y nota)\n")
  imprimirListadoAlumnos(alumnos.sorted(by:{($0.4 > $1.4) && ($0.3 > $1.3)}))
  
  print("\n array ordenado por nota final (media de los tres parciales, ponderados en: 0,35, 0,3, 0,35) (orden decreciente de nota final)\n")
  
  imprimirListadoAlumnos(alumnos.sorted(by:{($0.1*0.35+$0.2*0.3+$0.3*0.35) < ($1.1*0.35+$1.2*0.3+$1.3*0.35)}))
}

//print(imprimeListadosNotas(alumnos:listaAlumnos))

//EJERCICIO 5

print(listaAlumnos.filter({($0.1 > 5) && ($0.2 < 5)}).count )
//print(listaAlumnos.filter({($0.1*0.35+$0.2*0.3+$0.3*0.35)>=5}))

//EJERCICIO 6

