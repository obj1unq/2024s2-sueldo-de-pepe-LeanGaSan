object pepe {
    
    var categoria = cadete
    var bonoResultado = resultadoNulo
    var bonoPresentismo = presentismoNulo
    var faltas = 0
    //var neto -> esta variable está mal, es para precalcular!

    method categoria(_categoria) {
        categoria = _categoria
        // neto = _categoria() -> Esto es precálculo.  
    }

    method bonoResultado(_bonoResultado) {
        bonoResultado = _bonoResultado
    }

    method bonoPresentismo(_bonoPresentismo) {
        bonoPresentismo = _bonoPresentismo
    }

    method faltas(_faltas) {
        faltas = _faltas
    }

    method faltas() {
        return faltas
    }

    method sueldo() {
        return self.neto()  + self.extraResultado() + self.extraPresentismo() 
    }

    method neto() {
         // Este tipo de if (pregunta QUIEN es el objeto) hay que reemplazarlos por polimorfismo
        // if (categoria == gerente) {
        //     return 150000
        // }
        // if (categoria == cadete) {
        //     return 200000
        // }
        // return 0 //solucion de compromiso
        

       // return neto -> Esta es la solución de precálculo (precalculé el neto cuando me pasaron la categoría. Está mal! pudo variar)

        //Esta es la solucion polimorfica! la que va!
        return categoria.neto()
    }

    method extraResultado() {
        return bonoResultado.valor(self)
    }

    method extraPresentismo() {
        return bonoPresentismo.valor(self)
    }
}    

// categorias
object cadete {
    method neto() {
        return 20000
    }
}

object gerente {
    method neto() {
        return 15000
    }
}

// bonos de resultado

object fijo {
    method valor(empleado) {
        return 800
    }
}

object resultadoNulo {
    method valor(empleado) {
        return 0
    }
}

object porcentaje {
    
    method valor(empleado) { // Las opciones son pasar: el empleado, la categoria o el neto. La mejor es el empeado porque defino que el bono es algo que se aplica a un empleado. 
        return empleado.neto() * 0.1
    }
}
// bonos presentismo
object presentismoNulo {
    method valor(empleado) {
        return 0
    }
}

object normal {
    //method valor(faltas) { Estos ifs no están mal porque no tengo una solución mejor, es polimórfica. Pero se puede cambiar por una formulita haciéndolo más simple. 
    //    if (faltas == 0) {
    //        return 2000
    //    }
    //    if (faltas == 1) {
    //        return 1000
    //    }
    //    return 0
    //}
    method valor(empleado) {
        return (2000 - empleado.faltas() * 1000).max(0) // formulita más linda
    }
}

object ajuste {
    method valor(empleado) {
       return if (empleado.faltas() == 0) 100 else 0 // Usando el if como una expresión (operador ternario, funcion if else de intro) 
        // if (faltas = 0) -> Usando el if como estructura de control
        //  return 100 
        //else
        //  return 0
    }
}

object demagogico {
    method valor(empleado) {
        return if (empleado.neto() < 18000) 500 else 300
    }
}

//BONUS 
object sofia {
    var categoria = cadete
    var bonoResultado = resultadoNulo
    var bonoPresentismo = presentismoNulo
    var faltas = 0

    method categoria(_categoria) {
        categoria = _categoria
    }

    method bonoResultado(_bonoResultado) {
        bonoResultado = _bonoResultado
    }

    method bonoPresentismo(_bonoPresentismo) {
        bonoPresentismo = _bonoPresentismo
    }

    method faltas(_faltas) {
        faltas = _faltas
    }

    method faltas() {
        return faltas
    }

    method sueldo() {
        return self.neto() * 1.3 + self.extraResultado() + self.extraPresentismo() 
    }

    method neto() {
        return categoria.neto()
    }

    method extraResultado() {
        return bonoResultado.valor(self)
    }

    method extraPresentismo() {
        return bonoPresentismo.valor(self)
    }
}

object vendedor {
    method neto() {
        return 16000
    }
}

object medioTiempo {
    method categoriaBase(categoria) {
        return categoria.neto() / 2
    }
}

object roque {
    const neto = 28000
    var bonoResultado = resultadoNulo

	method bonoResultado(_bonoResultado) {
        bonoResultado = _bonoResultado
    }

    method sueldo() {
        return neto + self.extraResultado() + 9000
    }

    method extraResultado() {
        return bonoResultado.valor(self)
    }
}

object ernesto {
    var companiero = pepe
    var bonoPresentismo = presentismoNulo
    const property faltas = 0

    method companiero(_companiero) {
        companiero = _companiero
    }

    method neto() {
      return companiero.neto()
    }

    method sueldo() {
        return self.neto() + self.extraPresentismo()
    }

    method bonoPresentismo(_bonoPresentismo) {
        bonoPresentismo = _bonoPresentismo
    }

    method extraPresentismo() {
        return bonoPresentismo.valor(self)
    }
}
