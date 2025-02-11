extends Node


var score: int = 0
func add_point():
	score +=1
	print("Global Score:", score)
var gameStarted: bool
var playerBody: CharacterBody2D
var playerWeaponEquipped: bool

var playerAlive: bool
var playerDamageZone: Area2D
var playerDamageAmount: int

var batDamageZone = Area2D
var batDamageAmount: int

var frogDamageZone = Area2D
var frogDamageAmount: int
