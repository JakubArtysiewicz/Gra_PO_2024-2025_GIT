extends Node

var music_stream : AudioStream = load("res://resources/music/jazz-music-whiskey-bar-restaurant-casino-background-intro-theme-263181.mp3")
var music_player : AudioStreamPlayer
var is_playing : bool = false  # Flaga sprawdzająca, czy muzyka jest już odtwarzana

func _ready():
	if music_player == null:
		# Tworzymy nowy AudioStreamPlayer, jeśli jeszcze nie istnieje
		music_player = AudioStreamPlayer.new()
		add_child(music_player)  # Dodajemy go do aktualnej sceny

		# Ustawiamy, żeby muzyka grała w pętli
		music_player.autoplay = true

	if not is_playing:
		# Jeśli muzyka nie jest odtwarzana, uruchamiamy ją
		music_player.stream = music_stream
		music_player.play()
		is_playing = true

# Funkcja do zatrzymania muzyki
func stop_music():
	if music_player.is_playing():
		music_player.stop()
		is_playing = false

# Funkcja do wznowienia muzyki
func resume_music():
	if not music_player.is_playing() and is_playing:
		music_player.play()
