extends Control

@onready var narration: AudioStreamPlayer = $NarrationPlayer
@onready var subtitle: Label = $SubtitleLabel

# Each entry: [start time in seconds, subtitle text]
# An empty string clears the subtitle.
const LINES := [
	[0.0, "Willow Creek was a quiet town."],
	[4.0, "Mountain air, church bells, neighbors who waved from their porches."],
	[9.0, "Nobody locked their doors."],
	[12.0, ""],
	[15.0, "Then the sickness came."],
	[17.5, "First it was just a few people, feverish and confused."],
	[22.0, "Within a day, the hospital was overrun."],
	[27.0, "By nightfall, the sirens stopped, because there was no one left to answer them."],
	[37.0, ""],
	[40.0, "The ones who changed... they didn't stop."],
	[44.0, "They didn't sleep. They hunted anything that still breathed."],
	[50.0, "We ran with whatever we could carry."],
	[55.0, "There's one road out, a path winding up through the mountains to the evacuation point."],
	[62.0, "Everyone who stays behind is already lost."],
	[67.0, "I'm not staying. I'm getting out of here."],
]

var _index := -1


func _ready() -> void:
	subtitle.text = ""
	subtitle.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	subtitle.vertical_alignment = VERTICAL_ALIGNMENT_BOTTOM
	subtitle.offset_bottom = -60
	subtitle.add_theme_font_size_override("font_size", 44)
	subtitle.add_theme_color_override("font_color", Color.WHITE)
	subtitle.add_theme_color_override("font_outline_color", Color.BLACK)
	subtitle.add_theme_constant_override("outline_size", 6)
	narration.finished.connect(_on_narration_finished)


func _process(_delta: float) -> void:
	if not narration.playing:
		return
	var t := narration.get_playback_position()
	var next := _index + 1
	if next < LINES.size() and t >= LINES[next][0]:
		_index = next
		subtitle.text = LINES[_index][1]


func _on_narration_finished() -> void:
	subtitle.text = ""