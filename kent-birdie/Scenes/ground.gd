extends Node2D

@export var speed: float = -150

signal bird_crashed

@onready var sprite1: Sprite2D = $Ground1/Sprite2D
@onready var sprite2: Sprite2D = $Ground2/Sprite2D

var sprite_width: float


func _ready():
	# Get the real width of the ground sprite on screen
	sprite_width = sprite1.texture.get_width() * sprite1.scale.x

	# Place sprite2 exactly to the right of sprite1
	sprite2.global_position.x = sprite1.global_position.x + sprite_width


func _process(delta):
	# Move both sprites
	sprite1.global_position.x += speed * delta
	sprite2.global_position.x += speed * delta

	# Loop sprite1
	if sprite1.global_position.x < -sprite_width:
		sprite1.global_position.x = sprite2.global_position.x + sprite_width

	# Loop sprite2
	if sprite2.global_position.x < -sprite_width:
		sprite2.global_position.x = sprite1.global_position.x + sprite_width

 


func _on_body_entered(body: Node2D):
	bird_crashed.emit()
	stop()
	(body as Bird).stop()
	(body as Bird).stop()
	
func stop():
	speed = 0
