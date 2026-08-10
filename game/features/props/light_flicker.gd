extends OmniLight3D

@export var noise: FastNoiseLite
@export var energy_coefficient: float = 0.05
@export var energy_floor: float = 0.25

func _process(delta: float) -> void:
	light_energy = energy_floor + (noise.get_noise_1d(Time.get_ticks_msec()) * energy_coefficient)
