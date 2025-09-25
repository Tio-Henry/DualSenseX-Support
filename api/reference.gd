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
	
enum MicLED {
	ON,
	PULSE,
	OFF
}

enum TriggerMode {
		Normal,
		GameCube,
		VerySoft,
		Soft,
		Hard,
		VeryHard,
		Hardest,
		Rigid,
		VibrateTrigger,
		Choppy,
		Medium,
		VibrateTriggerPulse,
		CustomTriggerValue,
		Resistance,
		Bow,
		Galloping,
		SemiAutomaticGun,
		AutomaticGun,
		Machine,
		VIBRATE_TRIGGER_10Hz,
		OFF,
		FEEDBACK,
		WEAPON,
		VIBRATION,
		SLOPE_FEEDBACK,
		MULTIPLE_POSITION_FEEDBACK,
		MULTIPLE_POSITION_VIBRATION
		}

enum CustomTriggerValueMode {
		OFF,
		Rigid,
		RigidA,
		RigidB,
		RigidAB,
		Pulse,
		PulseA,
		PulseB,
		PulseAB,
		VibrateResistance,
		VibrateResistanceA,
		VibrateResistanceB,
		VibrateResistanceAB,
		VibratePulse,
		VibratePulseA,
		VibratePulsB,
		VibratePulseAB
		}
