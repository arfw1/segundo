/*enum Movimiento{
  case deposito(Double)
  case cargoRecibo(String,Double)
  case cajero(Double)
}

func aplica(movimientos:[Movimiento])->(Double,[String]){
  if movimientos.isEmpty{
    return(0,[])
  }else{
    let primero = movimientos[0]
    let resto = Array(movimientos.dropFirst())
    return acumula(mov:primero,res:aplica(movimientos:resto));
  }
}

func acumula(mov:Movimiento,res:(Double,[String]))->(Double,[String]){
  switch mov{
    case let .deposito(cantidad):
      return (res.0+cantidad,res.1)
    case let .cargoRecibo(desc,cantidad):
      return (res.0-cantidad,[desc]+res.1)
    case let .cajero(cantidad):
      return (res.0-cantidad,res.1)
  }
}

indirect enum ArbolBinario{
  case nodo (Int,ArbolBinario,ArbolBinario)
  case vacio
}

func suma(arbolb:ArbolBinario)->Int{
  switch arbolb{
    case let .nodo(num,izq,der):
      return num+suma(arbolb: izq)+suma(arbolb: der)
    case .vacio:
      return 0
  }
}

indirect enum Arbol{
  case nodo(Int,[Arbol])
}
func suma(arbol:Arbol,cumplen condicion:(Int)->Bool)->Int{
  switch arbol{
    case let .nodo(num,subarbol):
      if condicion(num){
        return num+suma(bosque:subarbol,cumplen:condicion);
      }
      return suma(bosque:subarbol,cumplen:condicion);
  }
}
func suma(bosque:[Arbol],cumplen:(Int)->Bool)->Int{
  if bosque.isEmpty{
    return 0
  }else{
    let primero = bosque[0]
    let resto = Array(bosque.dropFirst())
    return suma(arbol:primero,cumplen:cumplen)+suma(bosque:resto,cumplen:cumplen);
  }
}
let arbol1 = Arbol.nodo(1, [])
let arbol3 = Arbol.nodo(3, [arbol1])
let arbol5 = Arbol.nodo(5, [])
let arbol8 = Arbol.nodo(8, [])
let arbol10 = Arbol.nodo(10, [arbol3, arbol5, arbol8])

func esPar(x: Int) -> Bool {
    return x % 2 == 0
}

//print("La suma del árbol es: \(suma(arbol: arbol10, cumplen: esPar))")
// Imprime: La suma del árbol genérico es: 18

//PRÁCTICA 10
func maxOpt(_ x: Int?, _ y:Int?)->Int?{
   if (x != nil){
     if (y == nil){
       return x!
     }else{
       return max(x!,y!)
     }
   }else{
     if(y == nil){
       return nil
     }
     return y;
   }
}

func parejaMayorParImpar2(numeros:[Int])->(Int?,Int?){
  if numeros.isEmpty{
    return (nil,nil)
  }else{
    let primero = numeros[0]
    let resto = Array(numeros.dropFirst())
    return acumula(primero,parejaMayorParImpar2(numeros:resto) )
  }
}
func acumula(_ n:Int, _ res: (Int?,Int?))->(Int?, Int?){
  if n.isMultiple(of: 2){
    return (res.0,maxOpt(n,res.1))
  }else{
    return (maxOpt(n,res.0) , res.1)
  }
}

func sumaMaxParesImpares(numeros:[Int])->Int{
  if numeros.isEmpty{
    return 0
  }else{
    let res = parejaMayorParImpar2(numeros:numeros)
    if (res.0==nil){
      if(res.1==nil){
        return 0
      }
      else{
        return res.1!
      }
    }else{
      if(res.1==nil){
        return res.0!
      }else{
        return res.0!+res.1!
      }
    }
    
  }
}

// Imprime:
// sumaMaxParesImpares(numeros: [-10, 202, 12, 100, 204, 2])
// 204

//EJERCICIO3

func suma(palabras:[String],contienen:Character)->Int{
  palabras.reduce(0,{
    (res:Int,palabra:String)->Int in
      if palabra.contains(contienen){
        return res+palabra.count
      }
    return res
  })
}
  
func sumaMenoresMayores(nums: [Int], pivote: Int) -> (Int, Int){
  nums.reduce((0,0),{
    (res:(Int,Int),n:Int)->(Int,Int) in
      if n < pivote {
        return (res.0+n,res.1)
      } 
      return (res.0, res.1+n)
  })
}

func bar(f: (Int) -> Int) {
  print(f(4))
}

func foo() -> (Int) -> Int {
  var x = 3
  return {
    x += $0 + 2 // primero hace 3+4+2 y en la segunda llamada hace 3+9+2
    return x
  }
}

var x = 5
let g = foo()
bar(f: g)   // => 9
bar(f: g)   // => 15


indirect enum Arbol<T>{
  case nodo(T,[Arbol<T>])
}
func toArray<T>(arbol:Arbol<T>)->[T]{
  switch arbol{
    case let .nodo(dato,sub):
      return [dato]+toArray(bosque:sub)
  }
}
func toArray<T>(bosque:[Arbol<T>])->[T]{
  if let primero = bosque.first{
    let resto = Array(bosque.dropFirst())
    return toArray(arbol:primero)+toArray(bosque:resto)
  }else{
    return []
  }
}

let arbolInt: Arbol = .nodo(53, 
                            [.nodo(13, []), 
                             .nodo(32, []), 
                             .nodo(41, 
                                   [.nodo(36, []), 
                                    .nodo(39, [])
                                   ])
                            ])
let arbolString: Arbol = .nodo("Zamora", 
                               [.nodo("Buendía", 
                                      [.nodo("Albeza", []), 
                                       .nodo("Berenguer", []), 
                                       .nodo("Bolardo", [])
                                      ]), 
                                .nodo("Galván", [])
                               ])


print(toArray(arbol: arbolInt))
// Imprime: [53, 13, 32, 41, 36, 39]
func toArrayFOS(arbol:Arbol<T>)->[T]{
  switch arbol{
    case let .nodo(dato, sub):
      return sub.map(toArrayFOS).reduce([dato],+)
  }
}

typealias Alumno = (nombre:String,
                   notaParcial1:Double,
                   notaParcial2:Double,
                   notaParcial3:Double,
                   matriculacion:Int)
  

import Foundation

func imprimirListadoAlumnos(_ alumnos: [(String, Double, Double, Double, Int)]) {
    print("Alumno   Parcial1   Parcial2   Parcial3  Años")
    for alu in alumnos {
        alu.0.withCString {
            print(String(format:"%-10s %5.2f      %5.2f    %5.2f  %3d", $0, alu.1,alu.2,alu.3,alu.4))
        }
    }
}
func imprimirListadosNotas(alumnos:[Alumno]){
  print("array ordenado por nombre del alumno (orden alfabético creciente)")
  imprimirListadoAlumnos(alumnos.sorted(by:{a,b in a.nombre < b.nombre}))
  print("\nlistado 2: array ordenado por la nota del parcial 1 (orden decreciente de nota)")
  imprimirListadoAlumnos(alumnos.sorted(by: {a,b in a.notaParcial1 > b.notaParcial1}))
  print("\narray ordenado por la nota del parcial 2 (orden creciente de nota)")
  imprimirListadoAlumnos(alumnos.sorted(by:{a,b in a.notaParcial2 < b.notaParcial2}))
  print("\narray ordenado por año de matriculación y nota del parcial 3 (orden decreciente de año y nota)")
  imprimirListadoAlumnos(alumnos.sorted(by:{a,b in a.matriculacion > b.matriculacion && a.notaParcial3 > b.notaParcial3}))
  print("\narray ordenado por nota final (media de los tres parciales, ponderados en: 0,35, 0,3, 0,35) (orden decreciente de nota final)")
  imprimirListadoAlumnos(alumnos.sorted(by:{a,b in (a.notaParcial1*0.35+a.notaParcial2*0.3+a.notaParcial3*0.35) > (b.notaParcial1*0.35+b.notaParcial2*0.3+b.notaParcial3*0.35) }))

let listaAlumnos = [("Pepe", 8.45, 3.75, 6.05, 1), 
                    ("Maria", 9.1, 7.5, 8.18, 1), 
                    ("Jose", 8.0, 6.65, 7.96, 1),
                    ("Carmen", 6.25, 1.2, 5.41, 2), 
                    ("Felipe", 5.65, 0.25, 3.16, 3), 
                    ("Carla", 6.25, 1.25, 4.23, 2), 
                    ("Luis", 6.75, 0.25, 4.63, 2), 
                    ("Loli", 3.0, 1.25, 2.19, 3)]
//imprimirListadosNotas(alumnos: listaAlumnos)

//EJERCIOCIO 5
print(listaAlumnos.filter({($0.1 >= 5) && ($0.2 < 5)}).count)
print(listaAlumnos.filter({($0.1*0.35+$0.2*0.3+$0.3*0.35)>=5}).map({$0.0}))
}*/

func construye(operador: Character)->(Int,Int)->Int{
  switch operador{
    case "*":
      return {$0 * $1}
    case "-":
      return {$0 - $1}
    case "/":
      return {$0 / $1}
    default:
      return {$0 + $1}
  }
}
var f = construye(operador: "+")
print(f(2,3))
// Imprime 5
f = construye(operador: "-")
print(f(2,3))
// Imprime -1