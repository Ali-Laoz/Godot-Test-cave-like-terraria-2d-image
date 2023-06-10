extends Camera2D

var zoomed=false
var to_zoom=0.1
var to_move=1

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	
	if Input.get_action_strength("ui_page_down"):
		#zoom.set(Vector2(cnt,cnt))
		zoom += Vector2(to_zoom,to_zoom)
		
	
	if Input.get_action_strength("ui_page_up"):
		zoom -= Vector2(to_zoom,to_zoom)
		
	
	if Input.get_action_strength("ui_up"):
		offset-=Vector2(0,to_move)
		
	if Input.get_action_strength("ui_down"):
		offset+=Vector2(0,to_move)
	
	if Input.get_action_strength("ui_left"):
		offset-=Vector2(to_move,0)
		
	if Input.get_action_strength("ui_right"):
		offset+=Vector2(to_move,0)	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
