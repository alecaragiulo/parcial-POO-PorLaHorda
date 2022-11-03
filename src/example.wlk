class Personaje {
	var property fuerza
	var property rolDelPersonaje
	
	method potencialOfensivo() = fuerza * 10 + rolDelPersonaje.extra()
	
	method esGroso() = rolDelPersonaje.esGroso(self) || self.esInteligente()
	
	method esInteligente()
}


class Orco inherits Personaje{
	
	override method potencialOfensivo() = super() * 1.1
	
}


class Humano inherits Personaje{
	var inteligencia
	
	override method esInteligente() = inteligencia > 50
	
}



object guerrero{

	method extra() = 100	
	
	method esGroso(personaje) = personaje.fuerza() > 50
}


/*  object cazador{
	var poseeMascota
	
	method extra() = if(poseeMascota) mascota.potencialOfensivo() else 0
			
	method esGroso(personaje) = if(poseeMascota) mascota.esLongeva()	else false
	
}

object mascota{
	var fuerza
	var edad
	var poseeGarras
	
	method potencialOfensivo() {
		if(poseeGarras)
			return fuerza * 2
		else 
			return fuerza
	}	
	
	method esLongeva() = edad > 10
}
*/


// lo ideal seria hacer una class cazador y lo mismo con mascota

class Cazador {
	var mascota
	
	method extra() = mascota.potencialOfensivo()
	
	method esGroso(personaje) = mascota.esLongeva()
	
}

class Mascota {
	var fuerza
	var edad
	var poseeGarras
	
	method potencialOfensivo() = if(poseeGarras) fuerza*2 else fuerza
	
	method esLongeva() = edad > 10
	
}


object brujo{
	
	method potencialOfensivo(){}
	
	method esGroso(personaje) = true
	
}


class Localidad {
	var defensores = []
	
	method potencialDefensivo() = defensores.potencialOfensivo()
	
	method serOcupada(ejercito) {
		defensores = ejercito
	}
}

class Aldea inherits Localidad {
	const maxDefensores = 15
	
	override method serOcupada(ejercito) {
		
		if(ejercito.miembros().size() > maxDefensores){
			const nuevosHabitantes = ejercito.miembros().sortedBy{uno,otro => uno.potencialOfensivo() > otro.potencialOfensivo()}.take(10) 
			
			super( new Ejercito(miembros = nuevosHabitantes))
			
			ejercito.miembros().removeAll(nuevosHabitantes)	
			
		}
		
		else
			super(ejercito)
	}
}


class Ciudad inherits Localidad{
	
	override method potencialDefensivo() = super() + 300
}
	


class Ejercito {
	var miembros = []
	
	method potencialOfensivo() = miembros.sum{miembro => miembro.potencialOfensivo()}
	
	method invadirLocalidad(localidad) {
		if(localidad.potencialDefensivo() < self.potencialOfensivo())
			localidad.serOcupada(self)
	} 
}
