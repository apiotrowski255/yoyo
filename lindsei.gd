extends Node2D

var lindsei_sprite : AnimatedSprite2D
var lindsei_sprite_hand : AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	lindsei_sprite = get_node("lindsei_sprite")
	lindsei_sprite_hand = get_node("lindsei_sprite_hand")
	# print(lindsei_sprite.frame)
	# print(lindsei_sprite_hand.frame)
	lindsei_sprite_hand.visible = false
	# play_pat_animation()
	# play_catch_animation()
	play_idle_animation()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func play_catch_animation():
	lindsei_sprite.play("catch")

func play_pat_animation():
	lindsei_sprite.play("pat")
	lindsei_sprite_hand.visible = true
	lindsei_sprite_hand.play("pat")

func play_idle_animation():
	lindsei_sprite.play("default")
	lindsei_sprite_hand.visible = false

func _on_lindsei_sprite_animation_finished():
	if lindsei_sprite.animation == "catch":
		play_pat_animation()

