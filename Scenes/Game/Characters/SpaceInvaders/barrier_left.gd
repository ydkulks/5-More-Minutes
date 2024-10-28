extends AnimatedSprite2D
@onready var hp = 5

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body)
	#if body != static_body_2d:
	if hp == 5:
		animation="default"
	if hp == 4:
		animation="oneHit"
	if hp == 3:
		animation="twoHit"
	if hp == 2:
		animation="threeHit"
	if hp == 1:
		queue_free()
	hp = hp - 1
