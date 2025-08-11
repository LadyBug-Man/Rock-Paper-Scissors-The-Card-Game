extends Node2D

const CARD_SCENE_PATH = "res://Scenes/Card.tscn"
const CARD_DRAW_SPEED = 0.3
var  player_deck = ["Rock", "Rock", "Rock", "Rock"]
var can_draw = true




# Called when the node enters the scene tree for the first time.
func _ready():
	#Delete this rich text line and uncomment the others when you want the card count back
	$RichTextLabel.visible = false
	#print($Area2D.collision_mask)
	#$RichTextLabel.text = str(player_deck.size())
	draw_multiple_cards(3)
	

#When the deck is clicked draw a card and add it to your hand
func draw_card():
	
	#Checks to see if hand is full and stops player drawing if it is
	if not can_draw:
		print("Hand is full, Cannot Draw")
		return
	
	var card_drawn = player_deck[0]
	player_deck.erase(card_drawn)
	
	
	# If player frew the last card in the deck, disable the deck
	if player_deck.size() == 0:
		$Area2D/CollisionShape2D.disabled = true
		$Sprite2D.visible = false
		#$RichTextLabel.visible = false
	
	
	
	print("Draw Card")
	#$RichTextLabel.text = str(player_deck.size())
	var card_scene = preload(CARD_SCENE_PATH)
	var new_card = card_scene.instantiate()
	$"../CardManager".add_child(new_card)
	new_card.name = "Card"
	$"../PlayerHand".add_card_to_hand(new_card, CARD_DRAW_SPEED)
	
	
	#Draws No. of cards when called, call at the begining to fill initial hand
func draw_multiple_cards(amount: int):
	for i in range(min(amount, player_deck.size())):
		draw_card()
		await get_tree().create_timer(0.3).timeout

