extends CharacterBody2D

@export var speed : float = 300.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var direction : Vector2 = Vector2.ZERO
var last_direction : Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	player_movement(delta)
	
func get_direction() -> Vector2:
	direction.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	direction.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	return direction.normalized()

func player_movement(delta: float) -> void:
	direction = get_direction()
	
	if direction == Vector2.ZERO:
		velocity = Vector2.ZERO
		play_idle()
	else:
		last_direction = direction
		velocity = direction * speed
		play_walk()
		
	move_and_slide()
	
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
	
