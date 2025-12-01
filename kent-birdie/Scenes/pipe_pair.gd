extends Node2D
class_name PipePair

var speed: float = 0          # Speed of the pipes
var passed: bool = false      # Has the bird passed this pipe?

signal bird_entered
signal point_scored

var bird: Node2D = null       # Reference to the bird

func _ready():
	# Dynamically find the bird node in the scene
	bird = get_tree().get_current_scene().get_node_or_null("Bird")
	if bird == null:
		print("Warning: Bird node not found in PipePair!")

func set_speed(new_speed: float) -> void:
	speed = new_speed

func _process(delta: float) -> void:
	position.x += speed * delta

	# Emit point_scored once when bird passes pipe
	if bird != null and not passed and bird.global_position.x > global_position.x:
		passed = true
		point_scored.emit()
		print("PipePair: bird passed → +1 point")

	# Remove pipe when off-screen
	if position.x < -50:
		queue_free()

func _on_body_entered(body: Node) -> void:
	if body == bird:
		bird_entered.emit()
