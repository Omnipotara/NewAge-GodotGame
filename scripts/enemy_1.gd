extends CharacterBody2D

@export var speed : float = 80.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var player : Node2D
var direction : Vector2 = Vector2.ZERO
var last_direction : Vector2 = Vector2.DOWN

func _physics_process(delta: float) -> void:
	enemy_movement() # Svakog frame-a se poziva skripta za kretanje
	
func get_direction() -> void:
	if player != null:
		direction = (player.position - self.position).normalized() # Pravac se izracunava tako sto se oduzima pozicija igraca i neprijatelja
	else:
		direction = Vector2.ZERO # Ako igraca nema, nema ni pravca
		

func enemy_movement() -> void:
	get_direction() # Uzima pravac kretanja, ako player postoji ici ce ka njemu a ako je null ne krece se
	
	if direction == Vector2.ZERO:
		velocity = Vector2.ZERO
	else:
		last_direction = direction
		velocity = direction * speed
	
	movement_animation()
	move_and_slide()

func movement_animation() -> void:
	if direction == Vector2.ZERO:
		play_idle()
	else:
		play_walk()

func play_idle() -> void:
	if last_direction.x > 0:
		animated_sprite_2d.flip_h = false
		animated_sprite_2d.play("idle_side")
	elif last_direction.x < 0:
		animated_sprite_2d.flip_h = true
		animated_sprite_2d.play("idle_side")
	else:
		if last_direction.y > 0:
			animated_sprite_2d.play("idle_down")
		else:
			animated_sprite_2d.play("idle_up")
		
func play_walk() -> void:
	if direction.x > 0:
		animated_sprite_2d.flip_h = false
		animated_sprite_2d.play("walk_side")
	elif direction.x < 0:
		animated_sprite_2d.flip_h = true
		animated_sprite_2d.play("walk_side")
	else:
		if direction.y > 0:
			animated_sprite_2d.play("walk_down")
		else:
			animated_sprite_2d.play("walk_up")
	


func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body # Kada igrac udje u detection_area dodeljuje se atributu player


func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null # Kada igrac izadje iz detection_area brise se iz atributa player
