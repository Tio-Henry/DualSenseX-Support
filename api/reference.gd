extends Node

enum Trigger {
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
	
enum MicLED {
	ON,
	PULSE,
	OFF
}
