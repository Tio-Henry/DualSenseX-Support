extends Node

enum Trigger {
	Invalid,
	Left,
	Right
	}

enum InstructionType {
	GetDSXStatus,
	TriggerUpdate,
	RGBUpdate,
	PlayerLED,
	TriggerThreshold,
	MicLED,
	PlayerLEDNewRevision,
	ResetToUserSettings
	}

class Instruction:
	var type: InstructionType
	var parameters: Array
	
	func _init(_type: InstructionType, _parameters: Array) -> void:
		type = _type
		parameters = _parameters

class Packet:
	var instructions: Instruction
