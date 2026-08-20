extends Resource
class_name IngredientResource

enum State {FRESH, EXPIRED, COOKED, BURNT}

@export var name: StringName
@export var mesh: Mesh
@export var cook_time: float
@export var cooked_tint: Color
@export var burn_time: float
@export var burn_tint: Color
@export var expire_time: float
@export var expired_tint: Color
@export var crush_mesh: Mesh
@export var crush_color: Color

var is_cooking: bool = false
var crushed: bool = false
var descriptor: String
var state = State.FRESH
