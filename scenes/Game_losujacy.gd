extends Node2D

#PIK = Piki (♠) – karty w kolorze czarnym = 0
#KAR = Karo (♦) – karty w kolorze czerwonym = 1
#KIE = Kier (♥) – karty w kolorze czerwonym = 2
#TRE = Trefl (♣) – karty w kolorze czarnym = 3

#Listy kart już użytych
var karty_uzyte_piki = []
var karty_uzyte_karo = []
var karty_uzyte_kier = []
var karty_uzyte_trefl = []



#Lista kart
var lista_kart = [2,3,4,5,6,7,8,9,10,"A","J","Q","K"] 
var lista_nazw_kolorow = ["Pik","Karo","Kier","Trefl"]
var lista_dostepnych_kolorow = [0,1,2,3]

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func dobranie_karty():
	if karty_uzyte_piki.size() == 13:
		lista_dostepnych_kolorow.erase(0)
		
	if karty_uzyte_karo.size() == 13:
		lista_dostepnych_kolorow.erase(1)
		
	if karty_uzyte_kier.size() == 13:
		lista_dostepnych_kolorow.erase(2)
		
	if karty_uzyte_trefl.size() == 13:
		lista_dostepnych_kolorow.erase(3)
		
	#if lista_dostepnych_kolorow.size() != 0:
		
	var wybieranie_indexu_koloru = randi() % lista_dostepnych_kolorow.size()
	var wybieranie_koloru = lista_dostepnych_kolorow[wybieranie_indexu_koloru]
	
	if wybieranie_koloru == 0 and karty_uzyte_piki.size() != 13:
		
		var karta_wybrana_piki = wybieranie_kart_piki(karty_uzyte_piki)
		print(lista_nazw_kolorow[0],karta_wybrana_piki)
		karty_uzyte_piki.append(karta_wybrana_piki)
		print(karty_uzyte_piki)
		
	if wybieranie_koloru == 1 and karty_uzyte_karo.size() != 13:
		
		var karta_wybrana_karo = wybieranie_kart_karo(karty_uzyte_karo)
		print(lista_nazw_kolorow[1],karta_wybrana_karo)
		karty_uzyte_karo.append(karta_wybrana_karo)
		
	if wybieranie_koloru == 2 and karty_uzyte_kier.size() != 13:
		
		var karta_wybrana_kier = wybieranie_kart_kier(karty_uzyte_kier)
		print(lista_nazw_kolorow[0],karta_wybrana_kier)
		karty_uzyte_kier.append(karta_wybrana_kier)
		
		
	if wybieranie_koloru == 3 and karty_uzyte_trefl.size() != 13:
		var karta_wybrana_trefl = wybieranie_kart_trefl(karty_uzyte_trefl)
		print(lista_nazw_kolorow[0],karta_wybrana_trefl)
		karty_uzyte_trefl.append(karta_wybrana_trefl)
	
	#else:
		#dobranie_karty()	
		
		
		
func wybieranie_kart_piki(lista_kart_uzytych):
	var lista_kart_piki = lista_kart.duplicate()
	for i in lista_kart_uzytych:
		#if i in lista_kart_piki:
			lista_kart_piki.erase(i)
	var wybieranie_numeru_karty = randi() % lista_kart_piki.size()
	return lista_kart_piki[wybieranie_numeru_karty]
	
func wybieranie_kart_karo(lista_kart_uzytych):
	var lista_kart_karo = lista_kart.duplicate()
	for i in lista_kart_uzytych:
		if i in lista_kart_karo:
			lista_kart_karo.erase(i)
	var wybieranie_numeru_karty = randi() % lista_kart_karo.size()
	return lista_kart_karo[wybieranie_numeru_karty]
	
func wybieranie_kart_kier(lista_kart_uzytych):
	var lista_kart_kier = lista_kart.duplicate()
	for i in lista_kart_uzytych:
		if i in lista_kart_kier:
			lista_kart_kier.erase(i)
	var wybieranie_numeru_karty = randi() % lista_kart_kier.size()
	return lista_kart_kier[wybieranie_numeru_karty]
	
func wybieranie_kart_trefl(lista_kart_uzytych):
	var lista_kart_trefl = lista_kart.duplicate()
	for i in lista_kart_uzytych:
		if i in lista_kart_trefl:
			lista_kart_trefl.erase(i)
	var wybieranie_numeru_karty = randi() % lista_kart_trefl.size()
	return lista_kart_trefl[wybieranie_numeru_karty]

func _on_gra_pressed():
	dobranie_karty()
