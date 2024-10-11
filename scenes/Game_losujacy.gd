extends Node2D

#PIK = Piki (♠) – karty w kolorze czarnym = 0
#KAR = Karo (♦) – karty w kolorze czerwonym = 1
#KIE = Kier (♥) – karty w kolorze czerwonym = 2
#TRE = Trefl (♣) – karty w kolorze czarnym = 3

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
	
	if karty_piki.size() == 0:
		lista_dostepnych_kolorow.erase(0)
	if karty_karo.size() == 0:
		lista_dostepnych_kolorow.erase(1)
	if karty_kier.size() == 0:
		lista_dostepnych_kolorow.erase(2)
	if karty_trefl.size() == 0:
		lista_dostepnych_kolorow.erase(3)
	if lista_dostepnych_kolorow.size() > 0:
		var kolor_do_wylosowania = randi() % lista_dostepnych_kolorow.size()
		var kolor_wylosowany = lista_dostepnych_kolorow[kolor_do_wylosowania]
	
		if kolor_wylosowany == 0:
			var liczba_wylosowana = randi() % karty_piki.size()
			print("piki",karty_piki[liczba_wylosowana])
			karty_piki.erase(karty_piki[liczba_wylosowana])
		
		if kolor_wylosowany == 1:
			var liczba_wylosowana = randi() % karty_karo.size()
			print("karo",karty_karo[liczba_wylosowana])
			karty_karo.erase(karty_karo[liczba_wylosowana])
	
		if kolor_wylosowany == 2:
			var liczba_wylosowana = randi() % karty_kier.size()
			print("kier",karty_kier[liczba_wylosowana])
			karty_kier.erase(karty_kier[liczba_wylosowana])
	
		if kolor_wylosowany == 3:
			var liczba_wylosowana = randi() % karty_trefl.size()
			print("Trefl",karty_trefl[liczba_wylosowana])
			karty_trefl.erase(karty_trefl[liczba_wylosowana])
			
	else:
		print(null)
		
func _on_gra_pressed():
	losowanie_karty()
