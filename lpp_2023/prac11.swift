/*struct MiEstructura {
    var x = 0
}

class MiClase {
    var x = 0
}

func foo(_ c: MiClase, _ x: Int) {
    c.x = x
}

var s1 = MiEstructura()
var s2 = s1
var c1 = MiClase()
var c2 = c1

s1.x = 10
c1.x = 10
print ("s2.x: \(s2.x), c2.x: \(c2.x)") //("s2.x:0,c2.x:10")

foo(c1, 20)
print("c1.x, después de llamar a la función: \(c1.x)")// 20

struct Coord {
    var x: Double
    var y: Double

    func movida(incX: Double, incY: Double) -> Coord {
        return Coord(x: x+incX, y: y+incY)
    }

    mutating func mueve(incX: Double, incY: Double) {
        x = x + incX
        y = y + incY
    }
}

struct Cuadrado {
    var esquina = Coord(x: 0.0, y: 0.0)
    var lado: Double

    func movido1(x:Double, y:Double) ->Cuadrado{
      let cuadrado_res = Cuadrado(esquina:self.esquina.movida(incX: x, incY: y),lado:self.lado)
      return cuadrado_res
    }

    func movido2(x:Double,y:Double) ->Cuadrado{
      var cuadrado_res = self
      cuadrado_res.esquina.mueve(incX:x,incY:y)
      return cuadrado_res
    }

    // Añade un método mutador mueve
}

func foo(palabra: String, longitud: Int) -> Bool {
    if palabra.count >= longitud {
        return true
    }
    else {
        return false
    } 
}

class MisPalabras {
    var guardadas: [String] = []
    func guarda(_ palabra: String) {
        guardadas.append(palabra)
    }
    var x : [Bool] {
        get {
            return guardadas.map {foo(palabra: $0,longitud: 4)}
        }
    } 
}

let palabras = MisPalabras()
palabras.guarda("Ana")
palabras.guarda("Pascual")
palabras.guarda("María")
print(palabras.x)//[false,true,true]


//ejercicio 2
var x = 10  {
   didSet {
      if (x > 100) {
          x = oldValue
      }
   }
}

var y: Int {
    get {
        return x / 3
    }
    set {
      print("\(x)")
        x = 3 * newValue
      print("\(x)")
    }
}

var z : Int {
   get {
      return x + y
   }
   set {
      x = newValue / 2
      y = newValue / 2
   }
}
z = 60
print("y: \(y)") //"y:30"
print("x: \(x)")//"x:90"
z = 600
print("y: \(y)")//"30"
print("x: \(x)")//90

struct Valor {
    var valor: Int = 0 {
        willSet {
            Valor.z += newValue
        }        
        didSet {
            if valor > 10 {
                valor = 10
            }
        }
    }
    static var z = 0
}

var c1 = Valor()
var c2 = Valor()
c1.valor = 20
c2.valor = 8
print(c1.valor + c2.valor + Valor.z)//46
*/
struct Equipo{
  var nombre:String
  var puntos = 0
}

struct Partido{
  var equipo1:Equipo
  var equipo2:Equipo	
  var goleseq1:Int{
    willSet{
      equipo1.puntos+=newValue
    }
  }
  var goleseq2:Int{
    willSet{
      equipo1.puntos+=newValue
    }
  }
}

struct Liga{
  var equipos:[Equipo]=[]
  var partidos:[Partido]=[]
  mutating func añadeEquipo(equipo:Equipo){
   self.equipos+=[equipo]
  }
  mutating func añadePartido(partido:Partido){
    self.partidos+=[partido]
  }
}

var equipo1 = Equipo(nombre: "Madrid")
var equipo2 = Equipo(nombre: "Barcelona")
var partido1 = Partido(equipo1: equipo1, equipo2: equipo2, goleseq1: 2, goleseq2: 0)
var liga = Liga()
liga.añadeEquipo(equipo:equipo1)
liga.añadeEquipo(equipo:equipo2)
liga.añadePartido(partido:partido1)


print("\(liga.equipos.map(Equipo.nombre))")