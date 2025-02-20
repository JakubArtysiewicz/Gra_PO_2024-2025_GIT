#PIK = Piki (♠) – karty w kolorze czarnym = 0
#KAR = Karo (♦) – karty w kolorze czerwonym = 1
#KIE = Kier (♥) – karty w kolorze czerwonym = 2
#TRE = Trefl (♣) – karty w kolorze czarnym = 3

extends Node2D

var poczatkowa_wartosc_rozmieszczenia_kart_gracza_px = 550
var poczatkowa_wartosc_rozmieszczenia_kart_krupiera_px = 550
var poczatkowa_wartosc_rozmieszczenia_kart_gracza_py = 400
var poczatkowa_wartosc_rozmieszczenia_kart_krupiera_py = 150

var akutalny_wynik_gry = ""

var lista_obiektow_kart = []

var config_file = ConfigFile.new()

func cofanie_do_podstaw_karty():
	poczatkowa_wartosc_rozmieszczenia_kart_gracza_px = 550
	poczatkowa_wartosc_rozmieszczenia_kart_krupiera_px = 550
	poczatkowa_wartosc_rozmieszczenia_kart_gracza_py = 400
	poczatkowa_wartosc_rozmieszczenia_kart_krupiera_py = 150
	while lista_obiektow_kart.size() > 0:
		lista_obiektow_kart[0].visible = false
		lista_obiektow_kart.pop_front()

func wyswietl_karty_gra(rodzaj_gracza):
	if rodzaj_gracza == karty_gracza:
		wyswietl_karty(rodzaj_gracza[-1][0],rodzaj_gracza[-1][1],poczatkowa_wartosc_rozmieszczenia_kart_gracza_px,poczatkowa_wartosc_rozmieszczenia_kart_gracza_py)
		
		poczatkowa_wartosc_rozmieszczenia_kart_gracza_px += 50
				
	if rodzaj_gracza == karty_krupiera:
		wyswietl_karty(rodzaj_gracza[-1][0],rodzaj_gracza[-1][1],poczatkowa_wartosc_rozmieszczenia_kart_krupiera_px,poczatkowa_wartosc_rozmieszczenia_kart_krupiera_py)
		poczatkowa_wartosc_rozmieszczenia_kart_krupiera_px += 50

func wyswietl_karty(typ,numer,px,py):
	var sprite = Sprite2D.new()
	var texture = load("res://resources/pictures/cards/%s/%s.png"%[typ,numer])
	if texture == null:
		texture = load("res://resources/pictures/cards/%s/%s.jpg"%[typ,numer])
	sprite.texture = texture
	sprite.position = Vector2(px,py)
	sprite.scale = Vector2(0.2, 0.2)
	add_child(sprite)
	lista_obiektow_kart.append(sprite)
		

func aktualna_godzina():
	var datetime = Time.get_datetime_dict_from_system()
	var formatted_time = "%04d-%02d-%02d %02d:%02d:%02d" % [
		datetime.year,
		datetime.month,
		datetime.day,
		datetime.hour,
		datetime.minute,
		datetime.second
		]
	return formatted_time


func create_image_do_zetonow(sciezka_do_obrazka, wektor1, wektor2 ,lista_do_dodania):
	
	var random_wektor1 = randi_range(-4, 4)
	var random_wektor2 = randi_range(-4,4)
	
	var texture = load(sciezka_do_obrazka)
	var new_image = Sprite2D.new()
	new_image.texture = texture
	new_image.rotation= -32.7 
	new_image.position = Vector2(wektor1+random_wektor1, wektor2+random_wektor2)
	new_image.scale = Vector2(0.2, 0.2)
	add_child(new_image)
	lista_do_dodania.append(new_image)


func zapisywanie_gry():
	zapisywanie_gry_info()
	config_file.set_value("pieniadze", "wszystkie_pieniadze", wszystkie_pieniadze)
	config_file.set_value("pieniadze", "polozone_pieniadze", polozone_pieniadze)
	var blad = config_file.save("res://resources/config_files/config_files.cfg")
	if blad != OK:
		print("Błąd przy zapisywaniu pliku:", blad)
	
func zapisywanie_gry_info():
	var dodac_do_listy = str(aktualna_godzina()) + " " + str(wszystkie_pieniadze) + " " + str(akutalny_wynik_gry)   
	add_value_to_config_list_history(dodac_do_listy)	
		#
func odczytywanie_z_pliku_konf(sekcja, zmienna):
	var err =config_file.load("res://resources/config_files/config_files.cfg")
	if err == OK:
		var wartosci = config_file.get_value(sekcja, zmienna, 0)
		return wartosci
	else:
		print("Błąd przy ładowaniu pliku konfiguracyjnego:", err)
	
func add_value_to_config_list_history(value: String):
	config_file.load("res://resources/Config_files/config_files.cfg")
	var current_list = config_file.get_value("historia", "lista", [])
	current_list.append(value)  # Dodaj nową wartość
	config_file.set_value("historia", "lista", current_list)  # Zapisz zmodyfikowaną listę
	var err = config_file.save("res://resources/config_files/config_files.cfg")
	if err == OK:
		print("Lista zapisana pomyślnie:", current_list)
	else:
		print("Błąd zapisu:", err)

var karty_piki = [2,3,4,5,6,7,8,9,10,"A","J","Q","K"]
var karty_karo = [2,3,4,5,6,7,8,9,10,"A","J","Q","K"]
var karty_kier = [2,3,4,5,6,7,8,9,10,"A","J","Q","K"]
var karty_trefl = [2,3,4,5,6,7,8,9,10,"A","J","Q","K"]

var lista_dostepnych_kolorow = [0,1,2,3]

var karty_krupiera = []
var karty_gracza = []

var ilosc_postawionych_zetonow_100 = 0
var ilosc_postawionych_zetonow_500 = 0

var lista_nodeow_postawionych_zetonow_100 = []
var lista_nodeow_postawionych_zetonow_500 = []
		
func _ready():

	var card = get_node("karta_do_poruszania")
	#card.move_to(Vector2(poczatkowa_wartosc_rozmieszczenia_kart_gracza_px, poczatkowa_wartosc_rozmieszczenia_kart_gracza_py))
	
	Musicmanager
	randomize()
	
	var blad = config_file.load("res://resources/config_files/config_files.cfg")
	if blad != OK or config_file.get_value("game_data", "first_run", true):
		config_file.set_value("game_data", "first_run", false)
		config_file.set_value("pieniadze", "wszystkie_pieniadze", 10000)
		config_file.save("res://resources/config_files/config_files.cfg")
		
	$Popup.hide()
	$usuwniezeton100.visible = false
	$usuwniezeton500.visible = false
	$"2x".visible = false
	$Dobierz.visible = false
	$Niedobierz.visible = false

var wszystkie_pieniadze = odczytywanie_z_pliku_konf("pieniadze", "wszystkie_pieniadze")
var polozone_pieniadze = odczytywanie_z_pliku_konf("pieniadze","polozone_pieniadze")


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
			lista.append([0,karty_piki[liczba_wylosowana]])
			karty_piki.erase(karty_piki[liczba_wylosowana])
		
		if kolor_wylosowany == 1:
			var liczba_wylosowana = randi() % karty_karo.size()
			lista.append([1,karty_karo[liczba_wylosowana]])
			karty_karo.erase(karty_karo[liczba_wylosowana])
	
		if kolor_wylosowany == 2:
			var liczba_wylosowana = randi() % karty_kier.size()
			lista.append([2,karty_kier[liczba_wylosowana]])
			karty_kier.erase(karty_kier[liczba_wylosowana])
	
		if kolor_wylosowany == 3:
			var liczba_wylosowana = randi() % karty_trefl.size()
			lista.append([3,karty_trefl[liczba_wylosowana]])
			karty_trefl.erase(karty_trefl[liczba_wylosowana])
	else:
		print(null)
		
	wyswietl_karty_gra(lista)
		
func dobranie_na_start_krupier():
	
	losowanie_karty(karty_krupiera)
	
	losowanie_karty(karty_krupiera)

func dobieranie_na_start_gracz():
	
	losowanie_karty(karty_gracza)
	
	losowanie_karty(karty_gracza)

func _on_start_pressed():
	ilosc_postawionych_zetonow_100=0
	ilosc_postawionych_zetonow_500=0
	cofanie_do_podstaw_karty()
	$usuwniezeton100.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$usuwniezeton500.mouse_filter = Control.MOUSE_FILTER_IGNORE
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
	if wszystkie_pieniadze - polozone_pieniadze >= 0:
		for i in range(ilosc_postawionych_zetonow_500):
			_on_zeton_500_pressed()
		for i in range(ilosc_postawionych_zetonow_100):
			_on_zeton_100_pressed()
	else:
		show_popup("Za mało pieniedzy")
	$"2x".visible = false
		
		
func _on_zeton_500_pressed():
	if wszystkie_pieniadze>=500:
		if ilosc_postawionych_zetonow_500>0:
			create_image_do_zetonow("res://resources/pictures/zeton500.png",230,300,lista_nodeow_postawionych_zetonow_500)	
		ilosc_postawionych_zetonow_500 += 1
		polozone_pieniadze+=500
		wszystkie_pieniadze-=500
		$usuwniezeton500.visible = true
	else:
		show_popup("Za mało pieniedzy")
		
func _on_zeton_100_pressed():
	if wszystkie_pieniadze>=100:
		if ilosc_postawionych_zetonow_100>0:
			create_image_do_zetonow("res://resources/pictures/zeton100.png",170,190,lista_nodeow_postawionych_zetonow_100)
		ilosc_postawionych_zetonow_100 += 1 	
		polozone_pieniadze+=100
		wszystkie_pieniadze-=100
		$usuwniezeton100.visible = true
	else:
		show_popup("Za mało pieniedzy")

func przegrana():
	akutalny_wynik_gry = "Przegrana"
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
	$usuwniezeton100.mouse_filter = Control.MOUSE_FILTER_PASS
	$usuwniezeton500.mouse_filter = Control.MOUSE_FILTER_PASS
	usuwanie_po_grze_zetonow(lista_nodeow_postawionych_zetonow_100,$usuwniezeton100)
	usuwanie_po_grze_zetonow(lista_nodeow_postawionych_zetonow_500,$usuwniezeton500)	
	#cofanie_do_podstaw_karty()
	zapisywanie_gry()
	
# Zapisywnie gry po wygranej gracza
func wygrana():
	akutalny_wynik_gry="Wygrana"
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
	$usuwniezeton100.mouse_filter = Control.MOUSE_FILTER_PASS
	$usuwniezeton500.mouse_filter = Control.MOUSE_FILTER_PASS
	usuwanie_po_grze_zetonow(lista_nodeow_postawionych_zetonow_100,$usuwniezeton100)
	usuwanie_po_grze_zetonow(lista_nodeow_postawionych_zetonow_500,$usuwniezeton500)
	#cofanie_do_podstaw_karty()
	zapisywanie_gry()
	
# Zapisywnie gry po remisie gracza
func remis():
	akutalny_wynik_gry = "Remis"
	karty_piki = [2,3,4,5,6,7,8,9,10,"A","J","Q","K"]
	karty_karo = [2,3,4,5,6,7,8,9,10,"A","J","Q","K"]
	karty_kier = [2,3,4,5,6,7,8,9,10,"A","J","Q","K"]
	karty_trefl = [2,3,4,5,6,7,8,9,10,"A","J","Q","K"]
	lista_dostepnych_kolorow = [0,1,2,3]
	karty_krupiera = []
	karty_gracza = []
	wszystkie_pieniadze+=polozone_pieniadze
	polozone_pieniadze=0
	show_popup_longer("Remis")
	$"2x".visible = false
	$Dobierz.visible = false
	$Niedobierz.visible = false
	$BlackjackStol/Start.visible = true
	$usuwniezeton100.mouse_filter = Control.MOUSE_FILTER_PASS
	$usuwniezeton500.mouse_filter = Control.MOUSE_FILTER_PASS
	usuwanie_po_grze_zetonow(lista_nodeow_postawionych_zetonow_100,$usuwniezeton100)
	usuwanie_po_grze_zetonow(lista_nodeow_postawionych_zetonow_500,$usuwniezeton500)
	#cofanie_do_podstaw_karty()
	zapisywanie_gry()

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

func _on_usuwniezeton_100_pressed():
	if polozone_pieniadze>=100 and ilosc_postawionych_zetonow_100>=1:
		polozone_pieniadze-=100
		wszystkie_pieniadze+=100
		ilosc_postawionych_zetonow_100 -= 1
		if ilosc_postawionych_zetonow_100 == 0:
			$usuwniezeton100.visible = false
		if ilosc_postawionych_zetonow_100 != 0:
				lista_nodeow_postawionych_zetonow_100[-1].visible=false
				lista_nodeow_postawionych_zetonow_100.pop_back()
	

func _on_usuwniezeton_500_pressed():
	if polozone_pieniadze>=500 and ilosc_postawionych_zetonow_500>=1:
		polozone_pieniadze-=500
		wszystkie_pieniadze+=500
		ilosc_postawionych_zetonow_500 -= 1
		if ilosc_postawionych_zetonow_500 == 0:
			$usuwniezeton500.visible = false
		if ilosc_postawionych_zetonow_500 != 0:
				lista_nodeow_postawionych_zetonow_500[-1].visible=false
				lista_nodeow_postawionych_zetonow_500.pop_back()
				
func usuwanie_po_grze_zetonow(lista,przycisk):
	while lista.size() > 0:
		lista[0].visible = false
		lista.pop_front()
	przycisk.visible = false
		
		
func _on_back_pressed():
	if polozone_pieniadze>0 and $Dobierz.visible == true: 
		$ConfirmationDialog.popup_centered() 
	else: 
		get_tree().change_scene_to_file("res://scenes/menu.tscn")


func _on_confirmation_dialog_confirmed():
	przegrana() 
	get_tree().change_scene_to_file("res://scenes/menu.tscn")


