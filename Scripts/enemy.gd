extends CharacterBody3D


enum States {attack, idle, chase, die}

var state = States.idle
var hp = 15
var speed = 2


func _process(_delta):
	behavior()


func behavior():
	if state == States.idle:
		velocity = Vector3.ZERO
		#print("idle")
	elif state == States.chase:
		velocity = Vector3.ZERO
		#print("chase")
	elif state == States.attack:
		velocity = Vector3.ZERO
		#print("attack")
	elif state == States.die:
		velocity = Vector3.ZERO
		#print("die")
		
		
		
		# Getting an error here, not sure why 
		#
#func _on_chase_area_body_entered(body):
	#if body.has.method("player"):
		#state = States.chase
#
#func _on_chase_area_body_exited(body):
	#if body.has.method("player"):
		#state = States.idle
#
#func _on_attack_area_body_entered(body):
	#if body.has.method("player"):
		#state = States.attack
#
#func _on_attack_area_body_exited(body):
	#if body.has.method("player"):
		#state = States.chase
