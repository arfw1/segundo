func prefijos(prefijo:String , palabras:[String])->[Bool]{
  if palabras.isEmpty{
    return []
  }else{
    let primero = palabras[0]
    let resto = Array(palabras.dropFirst())
    if primero.hasPrefix(prefijo){
      return [true]+prefijos(prefijo:prefijo, palabras:resto)
    }else{
       return [false]+prefijos(prefijo:prefijo, palabras:resto)
    }
  }
}

let array = ["anterior", "antígona", "antena"]
let prefijo = "ante"
print("\n******\n2a) Función prefijos(prefijo:palabras:)\n******")
print(prefijos(prefijo: prefijo, palabras: array))

func parejaMayorParImpar(numeros:[Int])->(impar:Int,par:Int){
  let primero=numeros[0]
  let resto = Array(numeros.dropFirst())

  if(numeros.count==1){
    return (0,0)
  }else{
     let primero=numeros[0]
     let resto = Array(numeros.dropFirst())
     if(primero%2==0){
        if primero > parejaMayorParImpar(numeros: resto).par {
          return (parejaMayorParImpar(numeros: resto).impar , primero)
        }else{
          return (parejaMayorParImpar(numeros: resto).impar,parejaMayorParImpar(numeros: resto).par)
        }
      }else{
        if primero > parejaMayorParImpar(numeros: resto).impar {
          return (primero,parejaMayorParImpar(numeros: resto).par)
        }else{
          return (parejaMayorParImpar(numeros: resto).impar,parejaMayorParImpar(numeros: resto).par)
        }
     }
  }
}
/*
let numeros = [10, 201, 12, 103, 204, 2]
print("\n******\n2b) Función parejaMayorParImpar(numeros:)\n******")
print(parejaMayorParImpar(numeros: numeros))
// Imprime: (201, 204)*/

func compruebaParejas(_ numeros:[Int],funcion:(Int)->Int)->[(Int,Int)]{
  if numeros.count<=1{
    return[]
  }else{
    let primero=numeros[0]
    let resto=Array(numeros.dropFirst())
    let primero_resto=resto[0]
    if primero_resto==funcion(primero){
      return [(primero,primero_resto)]+compruebaParejas(resto, funcion: funcion)
    }else{
      return compruebaParejas( resto, funcion: funcion)
    }
  }
}
func cuadrado(x: Int) -> Int {
   return x * x
}
//print(compruebaParejas([2, 4, 16, 5, 10, 100, 105], funcion: cuadrado))
// Imprime [(2,4), (4,16), (10,100)]

func coinciden(parejas:[(Int,Int)],funcion:(Int)->Int)->[Bool]{
  if (parejas.isEmpty){
    return []
  }else{
    let primero=parejas[0]
    let resto = Array(parejas.dropFirst())
    if funcion(primero.0)==primero.1{
      return [true]+coinciden(parejas: resto, funcion: funcion)
    }else{
      return  [false] + coinciden(parejas: resto, funcion: funcion)
    }
  }
}
/*
let array = [(2,4), (4,14), (4,16), (5,25), (10,100)]
print(coinciden(parejas: array, funcion: cuadrado))
// Imprime: [true, false, true, true, true]*/

enum Movimiento{
  case deposito(Double)
  case cargoRecibo(String,Double)
  case cajero(Double)
}
func aplica(movimientos:[Movimiento])->(Double,[String]){
  if movimientos.isEmpty{
    return(0,[])
  }else{
    let primero=movimientos[0]
    let resto=Array(movimientos.dropFirst())
    
    switch primero{
      case let .deposito(cantidad):
        return (aplica(movimientos:resto).0 + cantidad, aplica(movimientos:resto).1)
      case let .cargoRecibo(desc,cantidad):
        return (aplica(movimientos:resto).0 - cantidad, [desc]+aplica(movimientos:resto).1)
      case let .cajero(cantidad):
        return (aplica(movimientos:resto).0 - cantidad, aplica(movimientos:resto).1)
    }
  }
}
/*
let movimientos: [Movimiento] = [.deposito(830.0), .cargoRecibo("Gimnasio", 45.0), .deposito(400.0), .cajero(100.0), .cargoRecibo("Fnac", 38.70)]
print(aplica(movimientos: movimientos))
//Imprime (1046.3, ["Gimnasio", "Fnac"])*/

indirect enum ArbolBinario{
  case vacio
  case nodo(Int,ArbolBinario,ArbolBinario)
}
func suma(arbolb:ArbolBinario)->Int{
  
    switch arbolb{
      case .vacio:
        return 0
      case let .nodo(dato,hijoiz,hijoder):
        return dato+suma(arbolb: hijoiz)+suma(arbolb:hijoder)
    }   
}
/*
let arbol: ArbolBinario = .nodo(8, 
                                .nodo(2, .vacio, .vacio), 
                                .nodo(12, .vacio, .vacio))
print(suma(arbolb: arbol))
// Imprime: 22*/

indirect enum Arbol{
  case nodo(Int,[Arbol])
}

func suma(arbol:Arbol, cumplen cond:(Int)->Bool)->Int{
  switch arbol{
    case let .nodo(dato,hijos):
      if (cond(dato)){
        return dato+suma(bosque:hijos,cumplen:cond)
      }else{
       return suma(bosque:hijos,cumplen:cond)
      }
  }
}
func suma(bosque:[Arbol],cumplen cond:(Int)->Bool)->Int{
  if(bosque.isEmpty){
    return 0
  }else{
     let primero=bosque[0]
     let resto=Array(bosque.dropFirst())
     return suma(arbol:primero,cumplen:cond)+suma(bosque:resto,cumplen:cond)
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

print("\n******\n6) Función suma(arbol:cumplen:)\n******")
print("La suma del árbol genérico es: \(suma(arbol: arbol10, cumplen: esPar))")