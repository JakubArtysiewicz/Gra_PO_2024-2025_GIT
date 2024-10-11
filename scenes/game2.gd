extends Node2D

#PIK = Piki (♠) – karty w kolorze czarnym = 0
#KAR = Karo (♦) – karty w kolorze czerwonym = 1
#KIE = Kier (♥) – karty w kolorze czerwonym = 2
#TRE = Trefl (♣) – karty w kolorze czarnym = 3

#Listy kart już użytych
var karty_piki = [2,3,4,5,6,7,8,9,10,"A","J","Q","K"]
var karty_karo = [2,3,4,5,6,7,8,9,10,"A","J","Q","K"]
var karty_kier = [2,3,4,5,6,7,8,9,10,"A","J","Q","K"]
var karty_trefl = [2,3,4,5,6,7,8,9,10,"A","J","Q","K"]

var lista_dostepnych_kolorow = [0,1,2,3]

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass
	
func losowanie_karty():
	
	
