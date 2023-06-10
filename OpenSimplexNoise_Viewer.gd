extends Control

# The OpenSimplexNoise object.
onready var noise=OpenSimplexNoise.new() 
var texture = ImageTexture.new()
var img = Image.new()


# Various noise parameters.
var min_noise 
var max_noise 
var ScreenResulation=Vector2(1000,1000)
var cordXY=Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	img.create(ScreenResulation.x, ScreenResulation.y, false, Image.FORMAT_RGBA8)
	texture.create_from_image(img)
	texture.flags=0
	
	# Set up noise with basic info.
	$ParameterContainer/SeedSpinBox.value = noise.seed
	$ParameterContainer/LacunaritySpinBox.value = noise.lacunarity
	$ParameterContainer/PeriodSpinBox.value = noise.period
	$ParameterContainer/PersistenceSpinBox.value = noise.persistence
	$ParameterContainer/OctavesSpinBox.value = noise.octaves
	_refresh_shader_params()
	



func _refresh_shader_params():
		# Get the texture data and lock it (to allow editing)
	# Generate some Noise for the height map
	
	#for x in range(ScreenResulation.x):
	#	for y in range(ScreenResulation.y):
	#		cordXY.x=x
	#		cordXY.x=y
			#get_node("TileMap").set_cellv((cordXY),-1)
	
	
	
	var noise = OpenSimplexNoise.new()
	noise.seed =  $ParameterContainer/SeedSpinBox.value
	noise.octaves =$ParameterContainer/OctavesSpinBox.value
	noise.period = $ParameterContainer/PeriodSpinBox.value
	noise.persistence = $ParameterContainer/PersistenceSpinBox.value
	noise.lacunarity=$ParameterContainer/LacunaritySpinBox.value 
	#generate_cave from cellular automata

	img.lock()
	for x in ScreenResulation.x:
		for y in ScreenResulation.y:
			var tile_id = generate_id(noise.get_noise_2d(x,y))
			cordXY.x=x
			cordXY.y=y
			if(tile_id != -1):
				img.set_pixelv(cordXY,Color.red)
			else:
				img.set_pixelv(cordXY,Color.transparent)
			
	img.unlock()	
	texture.set_data(img)	

func _on_DocumentationButton_pressed():
	#warning-ignore:return_value_discarded
	OS.shell_open("https://docs.godotengine.org/en/latest/classes/class_opensimplexnoise.html")


func _on_RandomSeedButton_pressed():
	$ParameterContainer/SeedSpinBox.value = floor(rand_range(-2147483648, 2147483648))
	_refresh_shader_params()

func _on_SeedSpinBox_value_changed(value):
	noise.seed = value
	

func _on_LacunaritySpinBox_value_changed(value):
	noise.lacunarity = value
	

func _on_PeriodSpinBox_value_changed(value):
	noise.period = value
	

func _on_PersistenceSpinBox_value_changed(value):
	noise.persistence = value
	

func _on_OctavesSpinBox_value_changed(value):
	noise.octaves = value
	

func _on_MinClipSpinBox_value_changed(value):
	min_noise = value



func _on_MaxClipSpinBox_value_changed(value):
	max_noise = value
	


func _on_Generate_new_toggled(button_pressed):
	_refresh_shader_params()
	pass # Replace with function body.



func generate_id(noise_level : float):
	if(noise_level <= -0.3):
		return -1
	else:
		return 2


func _set_texture(value):
	# If the texture variable is modified externally,
	# this callback is called.
	texture = value  # Texture was changed.
	update()  # Update the node's visual representation.


func _draw():
	draw_texture(texture, Vector2(100,100))
