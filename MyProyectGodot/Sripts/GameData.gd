extends Node

var nivel
var puntos
var mayorpuntaje
var datos_partida
var tutorialrealizado

func _ready():
	datos_partida  = {
	puntos = 0,
	mayorpuntaje = 0,
	nivel = "res://Scenes/Nivel 1.tscn"
	}
	

func guardar_partida():
	var save = File.new()
	save.open("user://RunAndJump_autosave.sav", File.WRITE)
	
	var datos_guardar = datos_partida
	datos_guardar.puntos = puntos
	datos_guardar.mayorpuntaje = mayorpuntaje
	datos_guardar.nivel = nivel
	
	save.store_line(to_json(datos_guardar))
	save.close()
	
func cargar_partida():
	var cargar = File.new()
	if !cargar.file_exists("user://RunAndJump_autosave.sav"):
		puntos = 0
		mayorpuntaje = 0
		nivel = "res://Scenes/Nivel 1.tscn"
		return
	
	cargar.open("user://RunAndJump_autosave.sav", File.READ)
	var datos_cargar = datos_partida
	while !cargar.eof_reached():
		var dato_provisorio = parse_json(cargar.get_line())
		if dato_provisorio != null:
			datos_cargar = dato_provisorio
			
	puntos = datos_cargar.puntos
	mayorpuntaje = datos_cargar.mayorpuntaje
	nivel = datos_cargar.nivel
	
	cargar.close()
	

func compararPuntajes(nuevoPuntaje):
	if nuevoPuntaje > mayorpuntaje:
		mayorpuntaje = nuevoPuntaje
	
