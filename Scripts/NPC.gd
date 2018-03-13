extends KinematicBody2D

const SMOOTH_SPEED = 2
var repos = Vector2()
var repos_velo = Vector2()
var position = Vector2()
var end = Vector2(437.21701, 174.684998)
var andar = false

func _ready():
	set_process(true)

func _process(delta):
	if andar == true:
		var destination = get_pos()
		repos.x = end.x - destination.x
		repos.y = end.y - destination.y
		repos_velo.x = repos.x * SMOOTH_SPEED * delta
		repos_velo.y = repos.y * SMOOTH_SPEED * delta

		position.x += repos_velo.x
		position.y += repos_velo.y

		move(repos_velo)
