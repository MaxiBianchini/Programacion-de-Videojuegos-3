extends Node2D

export (String) var siguiente_nivel
export (PackedScene) var Corazones
export (PackedScene) var Monedas
export (String) var nivel_actual
export (float) var vidas 

var arreglo_de_instrucciones =  [false,false,false,false]
var diferencia_corazones = 80
var diferencia_monedas = 50
var cantidad_monedas = 0
var menu_activo = false
var lista_vidas = []
var monedas = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	crear_vidas()
	get_tree().get_nodes_in_group("Music")[0].get_node("Gameplay").play()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	

func agarrar_moneda():
	monedas += 1
	

func _physics_process(_delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://Scenes/Menu.tscn")
	
	if vidas == 0 && menu_activo != true:
		$"POP UPs"/PopupPanel.popup()
		$"POP UPs"/PopupPanel.get_child(0).get_child(0).visible = false
		$"POP UPs"/PopupPanel.get_child(0).get_child(1).visible = true
		get_tree().get_nodes_in_group("Music")[0].get_node("Gameplay").stop()
		get_tree().get_nodes_in_group("Music")[0].get_node("Menu").play()
		$Jugador.pararJugador()
		menu_activo = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		

func _on_Bandera_Final_body_entered(body):
	if body.is_in_group("Jugador"):
		$"POP UPs"/PopupPanel.popup()
		$"POP UPs"/PopupPanel.get_child(0).get_child(0).visible = true
		$"POP UPs"/PopupPanel.get_child(0).get_child(1).visible = false
		
		get_tree().get_nodes_in_group("Music")[0].get_node("Gameplay").stop()
		get_tree().get_nodes_in_group("SFX")[0].get_node("WinLevel").play()
		get_tree().get_nodes_in_group("Music")[0].get_node("Menu").play()
		
		Puntos.puntos += 150 + ((30 * monedas) + (30 * vidas) ) #VER SI CAMBIO Y LO DIVIDO POR LAS VIDAS PERDIODAS
		Puntos.actualizar_puntos()
		
		$Jugador.pararJugador()
		menu_activo = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
		

func crear_monedas():
	var nueva_moneda = Monedas.instance()
	get_tree().get_nodes_in_group("Gui_Monedas")[0].add_child(nueva_moneda)
	nueva_moneda.global_position.x -= diferencia_monedas * cantidad_monedas
	cantidad_monedas += 1
	

func crear_vidas():
	for i in vidas:
		var nueva_vida = Corazones.instance()
		get_tree().get_nodes_in_group("Gui_Corazones")[0].add_child(nueva_vida)
		nueva_vida.global_position.x += diferencia_corazones * i
		lista_vidas.append(nueva_vida)
		

func perder_vidas():
	vidas -= 1
	if vidas >= 0:
		lista_vidas[vidas].queue_free()
		

# Menu si GANA
func _on_Boton_Siguiente_pressed():
	get_tree().get_nodes_in_group("Music")[0].get_node("Gameplay").stop()
	get_tree().get_nodes_in_group("SFX")[0].get_node("Botones").play()
	get_tree().change_scene(siguiente_nivel)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	

# Menu si PIERDE
func _on_Boton_Reiniciar_pressed():
	get_tree().get_nodes_in_group("Music")[0].get_node("Gameplay").stop()
	get_tree().get_nodes_in_group("SFX")[0].get_node("Botones").play()
	get_tree().change_scene(nivel_actual)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	

func _on_Boton_Menu_pressed():
	get_tree().get_nodes_in_group("Music")[0].get_node("Gameplay").stop()
	get_tree().get_nodes_in_group("SFX")[0].get_node("Botones").play()
	get_tree().change_scene("res://Scenes/Menu.tscn")
	
	

func _on_Boton_Salir_pressed():
	get_tree().quit()
	
func ocultar_tutorial():
	$"POP UPs"/PopupPanel.get_child(1).visible = false
	$"POP UPs"/PopupPanel.get_child(2).visible = false
	$"POP UPs"/PopupPanel.get_child(3).visible = false
	$"POP UPs"/PopupPanel.get_child(4).visible = false

func _on_Primer_Tutorial_body_entered(body):
	if body.is_in_group("Jugador") && !arreglo_de_instrucciones[0]:
		$"POP UPs"/PopupPanel.popup()
		$"POP UPs"/PopupPanel.get_child(0).get_child(0).visible = false
		$"POP UPs"/PopupPanel.get_child(0).get_child(1).visible = false
		$"POP UPs"/PopupPanel.get_child(1).visible = true
		arreglo_de_instrucciones[0] = true
		$Jugador.pararJugador()


func _on_Segundo_Tutorial_body_entered(body):
	if body.is_in_group("Jugador") && !arreglo_de_instrucciones[1]:
		$"POP UPs"/PopupPanel.popup()
		$"POP UPs"/PopupPanel.get_child(0).get_child(0).visible = false
		$"POP UPs"/PopupPanel.get_child(0).get_child(1).visible = false
		$"POP UPs"/PopupPanel.get_child(2).visible = true
		arreglo_de_instrucciones[1] = true
		$Jugador.pararJugador()


func _on_Tercer_Tutorial_body_entered(body):
	if body.is_in_group("Jugador") && !arreglo_de_instrucciones[2]:
		$"POP UPs"/PopupPanel.popup()
		$"POP UPs"/PopupPanel.get_child(0).get_child(0).visible = false
		$"POP UPs"/PopupPanel.get_child(0).get_child(1).visible = false
		$"POP UPs"/PopupPanel.get_child(3).visible = true
		arreglo_de_instrucciones[2] = true
		$Jugador.pararJugador()


func _on_Cuarto_Tutorial_body_entered(body):
	if body.is_in_group("Jugador") && !arreglo_de_instrucciones[3]:
		$"POP UPs"/PopupPanel.popup()
		$"POP UPs"/PopupPanel.get_child(0).get_child(0).visible = false
		$"POP UPs"/PopupPanel.get_child(0).get_child(1).visible = false
		$"POP UPs"/PopupPanel.get_child(4).visible = true
		arreglo_de_instrucciones[3] = true
		$Jugador.pararJugador()
