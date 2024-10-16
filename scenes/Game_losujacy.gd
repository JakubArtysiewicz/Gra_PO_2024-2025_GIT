extends Node2D
var wszystkie_pieniadze = 10000
var polozone_pieniadze = 0
	
#onready var popup = $Popup

#var test_sprawdzania_wartosci_kart1 = ["karo",["piki",2],["piki",2],["piki",3],["piki",5],["piki","A"]] #13
#var test_sprawdzenia_wartosci_kart2 = [["karo","A"],["karo","Q"],["karo",1]] #21

#PIK = Piki (♠) – karty w kolorze czarnym = 0
#KAR = Karo (♦) – karty w kolorze czerwonym = 1
#KIE = Kier (♥) – karty w kolorze czerwonym = 2
#TRE = Trefl (♣) – karty w kolorze czarnym = 3

var karty_piki = [2,3,4,5,6,7,8,9,10,"A","J","Q","K"]
var karty_karo = [2,3,4,5,6,7,8,9,10,"A","J","Q","K"]
var karty_kier = [2,3,4,5,6,7,8,9,10,"A","J","Q","K"]
var karty_trefl = [2,3,4,5,6,7,8,9,10,"A","J","Q","K"]

var lista_dostepnych_kolorow = [0,1,2,3]

var karty_krupiera = []
var karty_gracza = []

func _ready():
	
	$Popup.hide()
	
	
	#print(sprawdzenie_wartosci_kart(test_sprawdzania_wartosci_kart1))
	#print(sprawdzenie_wartosci_kart(test_sprawdzenia_wartosci_kart2))
	
	$"2x".visible = false
	$Dobierz.visible = false
	$Niedobierz.visible = false
	
func _process(delta):
	$wszystkiepieniadze.text = "wszystkie pieniadze: " + str(wszystkie_pieniadze)
	$postawionepieniadze.text = "postawione pieniadze: " + str(polozone_pieniadze)
	
	
func sprawdzenie_wartosci_kart(lista):
	var wartosci_kart = 0
	var ma_Asa = false
	
	for i in lista:
		
		if i[1] is int:
			wartosci_kart += i[1]
		if i[1] in ["J","K","Q"]:
			wartosci_kart += 10
		if i[1] in ["A"]:
			ma_Asa = true
			
	if ma_Asa:
		if wartosci_kart + 10 > 21:
			wartosci_kart += 1
		else:
			wartosci_kart += 10
	return(wartosci_kart)
			
		
func losowanie_karty(lista):
	
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
			lista.append(["piki",karty_piki[liczba_wylosowana]])
			#print("piki",karty_piki[liczba_wylosowana])
			karty_piki.erase(karty_piki[liczba_wylosowana])
		
		if kolor_wylosowany == 1:
			var liczba_wylosowana = randi() % karty_karo.size()
			lista.append(["karo",karty_karo[liczba_wylosowana]])
			#print("karo",karty_karo[liczba_wylosowana])
			karty_karo.erase(karty_karo[liczba_wylosowana])
	
		if kolor_wylosowany == 2:
			var liczba_wylosowana = randi() % karty_kier.size()
			lista.append(["kier",karty_kier[liczba_wylosowana]])
			#print("kier",karty_kier[liczba_wylosowana])
			karty_kier.erase(karty_kier[liczba_wylosowana])
	
		if kolor_wylosowany == 3:
			var liczba_wylosowana = randi() % karty_trefl.size()
			lista.append(["trefl",karty_trefl[liczba_wylosowana]])
			#print("trefl",karty_trefl[liczba_wylosowana])
			karty_trefl.erase(karty_trefl[liczba_wylosowana])
			
	else:
		print(null)
		
func dobranie_na_start_krupier():
	losowanie_karty(karty_krupiera)
	losowanie_karty(karty_krupiera)

func dobieranie_na_start_gracz():
	losowanie_karty(karty_gracza)
	losowanie_karty(karty_gracza)

func _on_start_pressed():
	if polozone_pieniadze != 0:
		$"2x".visible = true
		$Dobierz.visible = true
		$Niedobierz.visible = true
	
		dobranie_na_start_krupier()
		dobieranie_na_start_gracz()
	
		print("Karty gracza:", karty_gracza, sprawdzenie_wartosci_kart(karty_gracza))
		print("Karty krupiera:", karty_krupiera, sprawdzenie_wartosci_kart(karty_krupiera))

		$BlackjackStol/Start.visible = false 
	else:
		show_popup("Prosze dodać zakład")
		
	

func _on_dobierz_pressed():
	losowanie_karty(karty_gracza)
	print(karty_gracza,sprawdzenie_wartosci_kart(karty_gracza))
	if sprawdzenie_wartosci_kart(karty_gracza)>21:
		przegrana()
		

func _on_niedobierz_pressed():
	while sprawdzenie_wartosci_kart(karty_krupiera)<17:
		losowanie_karty(karty_krupiera)
		print(karty_krupiera,sprawdzenie_wartosci_kart(karty_krupiera))
	if sprawdzenie_wartosci_kart(karty_krupiera) < sprawdzenie_wartosci_kart(karty_gracza) and sprawdzenie_wartosci_kart(karty_gracza)!=21 and sprawdzenie_wartosci_kart(karty_krupiera)!=20:
		losowanie_karty(karty_krupiera)
		print(karty_krupiera,sprawdzenie_wartosci_kart(karty_krupiera))
	if sprawdzenie_wartosci_kart(karty_krupiera)>21:
		wygrana()
	if sprawdzenie_wartosci_kart(karty_gracza)>sprawdzenie_wartosci_kart(karty_krupiera):
		wygrana()
	if sprawdzenie_wartosci_kart(karty_gracza)<sprawdzenie_wartosci_kart(karty_krupiera):
		przegrana()
	if sprawdzenie_wartosci_kart(karty_krupiera)==sprawdzenie_wartosci_kart(karty_gracza):
		remis()
		
func _on_x_pressed():
	polozone_pieniadze += polozone_pieniadze
	wszystkie_pieniadze -= polozone_pieniadze
	
func _on_zeton_500_button_pressed():
	polozone_pieniadze+=500
	wszystkie_pieniadze-=500

func _on_zeton_100_button_pressed():
	polozone_pieniadze+=100
	wszystkie_pieniadze-=100

func przegrana():
	
	karty_piki = [2,3,4,5,6,7,8,9,10,"A","J","Q","K"]
	karty_karo = [2,3,4,5,6,7,8,9,10,"A","J","Q","K"]
	karty_kier = [2,3,4,5,6,7,8,9,10,"A","J","Q","K"]
	karty_trefl = [2,3,4,5,6,7,8,9,10,"A","J","Q","K"]

	lista_dostepnych_kolorow = [0,1,2,3]

	karty_krupiera = []
	karty_gracza = []
	
	print("przegrana")
	wszystkie_pieniadze-=polozone_pieniadze 
	polozone_pieniadze=0
	
	show_popup_longer("przegrana")
	
	$"2x".visible = false
	$Dobierz.visible = false
	$Niedobierz.visible = false
	
	$BlackjackStol/Start.visible = true
	
func wygrana():
	karty_piki = [2,3,4,5,6,7,8,9,10,"A","J","Q","K"]
	karty_karo = [2,3,4,5,6,7,8,9,10,"A","J","Q","K"]
	karty_kier = [2,3,4,5,6,7,8,9,10,"A","J","Q","K"]
	karty_trefl = [2,3,4,5,6,7,8,9,10,"A","J","Q","K"]

	lista_dostepnych_kolorow = [0,1,2,3]

	karty_krupiera = []
	karty_gracza = []
	
	print("wygrana")
	wszystkie_pieniadze+=(polozone_pieniadze*2)
	polozone_pieniadze=0
	show_popup_longer("wygrana")
	
	$"2x".visible = false
	$Dobierz.visible = false
	$Niedobierz.visible = false
	
	$BlackjackStol/Start.visible = true
	
func remis():
	karty_piki = [2,3,4,5,6,7,8,9,10,"A","J","Q","K"]
	karty_karo = [2,3,4,5,6,7,8,9,10,"A","J","Q","K"]
	karty_kier = [2,3,4,5,6,7,8,9,10,"A","J","Q","K"]
	karty_trefl = [2,3,4,5,6,7,8,9,10,"A","J","Q","K"]

	lista_dostepnych_kolorow = [0,1,2,3]

	karty_krupiera = []
	karty_gracza = []
	show_popup_longer("Remis")
	
	$"2x".visible = false
	$Dobierz.visible = false
	$Niedobierz.visible = false
	
	$BlackjackStol/Start.visible = true

func show_popup(message): 
	$Popup.get_node("Label").text = message  
	$Popup.popup_centered()
	$popup_timer.start()
	
func show_popup_longer(message):
	$Popup.get_node("Label").text = message  
	$Popup.popup_centered()
	$popup_timer2.start()

func _on_popup_timer_timeout():
	$Popup.hide()

func _on_popup_timer_2_timeout():
	$Popup.hide()
