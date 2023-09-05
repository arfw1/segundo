/*protocol A {
    var a: String {get}
    func foo(a: String) -> String?
}
protocol B {
    mutating func bar()
}
struct MiStruct: A, B {
    var a:String
    func foo(a:String)->String?{
      if a == ""{
        return nil
      }else{
        return a
      }
    }
    mutating func bar(){
      self.a = "hola"
    }


protocol A {
    var a: Int {get set}
    func foo(a: Int, b: Int) -> Int?
}

protocol B {
    mutating func bar()
}

struct MiStruct: A, B {
    var a = 10
    func foo(a: Int, b: Int) -> Int? {
        let res = a > 10 ? a: b
        return res
    }
    mutating func bar(){
      self.a=15
    }
}

struct Equipo:Equatable,Comparable{
    let puntos: Int
    let nombre: String
  
  static func < (primero:Equipo,segundo:Equipo)->Bool{
    primero.puntos < segundo.puntos ||
(primero.puntos == segundo.puntos && primero.nombre < segundo.nombre)
  }
}}

struct Cuadrado {
    var lado: Double
}
extension Cuadrado{
  var area :Double{
                   lado*lado}
}
// Completa el código justo a continuación,
// no puedes modificar el código anterior

var cuadrado = Cuadrado(lado: 4.0)
print(cuadrado.area) // Imprime: 16.0
cuadrado.lado = 10.0
print(cuadrado.area) // Imprime: 100.0

protocol Persona {
    var nombre: String {get}
    func encantada() -> Persona 
    func refrescada() -> Persona 
}

enum Pocion {
    case magica, refrescante, venenosa

    func esBebida(por persona: Persona) -> Persona? {
        switch persona {
            case .magica:
                return persona.encantada()
            case .refrescante:
                return persona.refrescada()
            default:
                return nil
        }
    }
}
*/
protocol A {
    var valor: Int {get set}
    func foo(a: Int) -> Int
}
protocol B {
    mutating func bar()
}
struct MiStruct: A, B {
    var valor:Int
  func foo(a:Int)->Int{
    return a
  }
  mutating func bar(){
    self.valor=20
  }

}
struct Circulo {
    var radio: Double
    static func + (c1:Circulo,c2:Circulo)->Circulo{
      return Circulo(radio:(c1.radio+c2.radio))
    }

}

let c1 = Circulo(radio: 5.0)
let c2 = Circulo(radio: 10.0)
let c3 = c1 + c2
print("El radio de la suma es: \(c3.radio)")
// Imprime: El radio de la suma es: 15.0


protocol P {
   var p: Int { get }
}
class A1: P {
   var p = 0
   var a1 = 0
}
class A2: P {
   var p = 1
   var a2 = 0
}

var array: [P] = [A1(), A2()]
for i in array {
  if let x = i as? A1{
    print("p:\(x.p) , a1: \(x.a1)")
  }else if let x = i as? A2{
    print("p:\(x.p) , a1: \(x.a2)")
  }
}

// debe imprimir:
// debe imprimir:
// p: 0, a1: 0
// p: 1, a2: 0










