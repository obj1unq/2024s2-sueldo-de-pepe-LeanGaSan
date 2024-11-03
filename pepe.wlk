

object pepe {
    
    var categoria = cadete
    var bonoResultado = porcentaje
    var bonoPresentismo = normal
    var faltas = 0

    method faltas(_faltas){
        faltas = _faltas
    }

    method categoria(_categoria){
        categoria = _categoria
    }

    method bonoResultado(_bonoResultado){
        bonoResultado = _bonoResultado
    }

    method bonoPresentismo(_bonoPresentismo){
        bonoPresentismo = _bonoPresentismo 
    }

    method faltas() {
        return faltas
    } 

    method sueldo() {
        return self.neto() + self.bonoResultado() + self.bonoPresentismo()
    }

    method neto() {
        return categoria.gananciaNeto()
    }

    method bonoResultado() {
        return bonoResultado.valor(self)
    }

    method bonoPresentismo() {
        return bonoPresentismo.valor(self)
    }

}

// TIPOS DE BONOS POR PRESENTISMO
object normal {
    
    method valor(empleado) {
        return 2000 - self.valorAgregado(empleado)
    }

    method valorAgregado(empleado) {
        return (empleado.faltas() * 1000).min(2000)
    }

}

object ajuste {
  
    method valor(empleado) {
        return if (empleado.faltas() == 0) 100 else 0 
    }

}

object demagogico {
  
    method valor(empleado) {
        return if (empleado.neto() < 18000 ) 500 else 300
    }

}

// TIPOS DE BONOS POR RESULTADOS
object porcentaje {

    method valor(empelado) {
        return empelado.neto() * 10 / 100 // == empleado.neto() * 0.1
    }

}

object montoFijo {
    
    method valor(empleado) {
        return 800
    }

}


// SIRVE PARA LOS DOS BONOS
object nulo {
  
    method valor(empleado) {
        return 0
    }
    
}

// CATEGORÍAS
object gerente {

    method gananciaNeto() {
        return 15000
    }

}

object cadete {
    
    method gananciaNeto() {
        return 20000
    } 

}
// VARIANTES:
/* 1. Definir a Sofía, otra persona de la que hay que calcular el sueldo. Sofía solamente tiene bono por resultados, o sea que su sueldo se calcula como neto + bono x resultados.
A su vez, su neto es un 30% superior a lo que indica su categoría. P.ej. si Sofía es cadete, su neto es 26000. Recordar que para aumentar un número un 30%, se lo multiplica por 1.3.
Atención: si Pepe, o cualquier otra persona que se agregue, es cadete, su neto es 20000. El incremento del 30% se aplica solamente a Sofía. */
object sofia {
    
    var bonoResultado = nulo
    var categoria = cadete

    method categoria(_categoria) {
      categoria = _categoria
    }

    method bonoResultado(_bonoResultado) {
        bonoResultado = _bonoResultado
    }

    method sueldo() {
        return self.neto() + self.bonoResultado()
    }

    method neto() {
        return categoria.neto() * 1.3
    }

    method bonoResultado() {
        return bonoResultado.valor(self)
    }

}

/* 2. Agregar las siguientes categorías

- vendedor:
su neto es de 16000 pesos. Si hay muchas ventas, hay un aumento de 25% (multiplicar por 1.25), o sea pasa a 20000.
El objeto que representa a esta categoría tiene que entender los mensajes activarAumentoPorMuchasVentas() y desactivarAumentoPorMuchasVentas().

- medio tiempo: en realidad, es un modificador sobre otra categoría, que se asigna enviando el mensaje medioTiempo.categoriaBase(categoria). Indica que la persona trabaja medio tiempo, por lo tanto su neto es la mitad (dividir por dos) de lo que indica la categoría base.
P.ej. si definimos medioTiempo.categoriaBase(gerente), entonces el neto de medioTiempo es 7500 (la mitad de 15000).
*/
object vendedor {
    
    var property valorAgregado = self.activarAumentoPorMuchasVentas()

    method gananciaNeto() {
        return 16000 * valorAgregado 
    }
    
    method activarAumentoPorMuchasVentas() {
        return 1.25
    }

    method desactivarAumentoPorMuchasVentas() {
        return 1
    }

}

object medioTiempo {

    var categoria = cadete

    method categoriaBase(_categoria) {
        categoria = _categoria
    }

    method gananciaNeto() {
        return categoria.gananciaNeto() / 2
    }

}

/* 3. Agregar dos personas más, según lo que se detalla a continuación.

Roque, que en lugar de asignársele una categoría, se establece un neto de 28000 �pesos.
El sueldo se calcula como neto + bono por resultados + 9000 pesos.
Para el bono por resultados, se usan las mismas opciones que para Pepe.

Ernesto, que trabaja junto con un compañero, que puede cambiar. El neto de Ernesto es igual al de su compañero.
Su sueldo se calcula como neto + bono por presentismo.
Para el bono por presentismo, usar las mismas opciones que para Pepe. Se sabe que Ernesto no falta nunca. */

object roque {
  
    const property neto = 28000
    var bonoResultado = nulo

    method sueldo() {
        return neto + self.bonoResultado() + 9000
    }

    method bonoResultado() {
        return bonoResultado.valor(self)
    }

    method bonoResultado(_bonoResultado){
        bonoResultado = _bonoResultado
    }

}

object ernesto {
    
    var property companiero = pepe
    var bonoPresentismo = nulo
    const property faltas = 0

    method neto() {
        return companiero.neto()
    }

    method sueldo() {
        return self.neto() + self.bonoPresentismo()
    }

    method bonoPresentismo(_bonoPresentismo){
        bonoPresentismo = _bonoPresentismo 
    }

    method bonoPresentismo() {
        return bonoPresentismo.valor(self)
    }    

}
