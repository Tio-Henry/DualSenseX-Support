@icon("res://addons/dualsensex_support/logo.png")
extends Node

var DSXServer: PacketPeerUDP = PacketPeerUDP.new()

func _enter_tree() -> void:
	DSXRef.process_thread_group = Node.PROCESS_THREAD_GROUP_SUB_THREAD
	process_thread_group = Node.PROCESS_THREAD_GROUP_SUB_THREAD

func connect_to(ip: String, port: int) -> Error:
	# This method uses the IP and port to establish a UDP connection with DualSenseX.
	
	return DSXServer.connect_to_host(ip, port)

func get_dsx_info() -> String:
	# This method requests information from DualSenseX about the connected controllers.
	
	var data: String = ""
	if not send_data({"type": DSXRef.InstructionType.GetDSXStatus}):
		while DSXServer.get_available_packet_count() != 0:
			data = DSXServer.get_packet().get_string_from_ascii()
		return data
	else:
		return ""

func adaptive_trigger(device: int, trigger: DSXRef.Trigger, trigger_mode: DSXRef.TriggerMode, parameters: Array[int] = []) -> Error:
	# This method sends a new instruction to the adaptive triggers.

		# device : Controller ID;
		# trigger : Left or Right trigger;
		# trigger_mode : Trigger action mode;
		# parameters : Additional parameters for configuring the trigger action mode.
		
	var instruction: Dictionary = {"type": DSXRef.InstructionType.TriggerUpdate, "parameters": [device,trigger,trigger_mode]}
	if not parameters.is_empty():
		instruction.parameters.append_array(parameters)
	return send_data(instruction)
	
func lightbar_led(device: int, color: Color, brightness: int) -> Error:
	# This method requests a change in the color and brightness of the controller's lightbar.

		# device : Controller ID;
		# color : New color;
		# brightness : Brightness level.
	
	return send_data({"type": DSXRef.InstructionType.RGBUpdate, "parameters": [device, color.r8, color.g8, color.b8, brightness]})

func player_led(device: int, player_number: int) -> Error:
	# This method sets a new player number for the controller LEDs.

		# device : Controller ID;
		# player_number : Player number.
			
	if player_number < 6:
		if player_number == 0:
			return send_data({"type": DSXRef.InstructionType.PlayerLEDNewRevision, "parameters": [device, 5]})
		else:
			return send_data({"type": DSXRef.InstructionType.PlayerLEDNewRevision, "parameters": [device, player_number - 1]})
	else:
		return Error.ERR_INVALID_PARAMETER

func mic_led(device: int, state: DSXRef.MicLED) -> Error:
	# This method changes the state of the microphone LED.
	
		# device : Controller ID;
		# state : LED state (ON, PULSE, OFF).
	
	return send_data({"type": DSXRef.InstructionType.MicLED, "parameters": [device, state]})
	
func reset_settings(device: int) -> Error:
	# This method requests to restore the controller profile to its default settings.

		# device : Controller ID.

	return send_data({"type": DSXRef.InstructionType.ResetToUserSettings,"parameters": [device]})

func send_data(instruction: Dictionary) -> Error:
	# This method sends a new instruction to DualSenseX.

		# instruction : New instruction.

	var json_result: JSON = JSON.new()
	var data: String = json_result.stringify({"instructions": [instruction]})
	return DSXServer.put_packet(data.to_ascii_buffer())
