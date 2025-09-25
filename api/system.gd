extends Node

var DSXServer: PacketPeerUDP = PacketPeerUDP.new()

func _enter_tree() -> void:
	DSXRef.process_thread_group = Node.PROCESS_THREAD_GROUP_SUB_THREAD
	process_thread_group = Node.PROCESS_THREAD_GROUP_SUB_THREAD

func _exit_tree() -> void:
	reset_settings(0)

func connect_to(ip: String, port: int) -> Error:
	return DSXServer.connect_to_host(ip, port)

func get_dsx_info() -> String:
	var data: String = ""
	if not send_data({"type": DSXRef.InstructionType.GetDSXStatus}):
		while data == "":
			data = DSXServer.get_packet().get_string_from_ascii()
		return data
	else:
		return ""

func adaptive_trigger(device: int, trigger: DSXRef.Trigger, trigger_mode: DSXRef.TriggerMode, parameters: Array[int] = []) -> Error:
	var instruction: Dictionary = {"type": DSXRef.InstructionType.TriggerUpdate, "parameters": [device,trigger,trigger_mode]}
	if not parameters.is_empty():
		instruction.parameters.append_array(parameters)
	return send_data(instruction)
	
func lightbar_led(device: int, color: Color, brightness: int) -> Error:
	return send_data({"type": DSXRef.InstructionType.RGBUpdate, "parameters": [device, color.r8, color.g8, color.b8, brightness]})

func player_led(device: int, player_number: int) -> Error:
	if player_number < 6:
		if player_number == 0:
			return send_data({"type": DSXRef.InstructionType.PlayerLEDNewRevision, "parameters": [device, 5]})
		else:
			return send_data({"type": DSXRef.InstructionType.PlayerLEDNewRevision, "parameters": [device, player_number - 1]})
	else:
		return Error.ERR_INVALID_PARAMETER

func mic_led(device: int, state: DSXRef.MicLED) -> Error:
	return send_data({"type": DSXRef.InstructionType.MicLED, "parameters": [device, state]})
	
func reset_settings(device: int) -> Error:
	return send_data({"type": DSXRef.InstructionType.ResetToUserSettings,"parameters": [device]})

func send_data(instruction: Dictionary) -> Error:
	var json_result: JSON = JSON.new()
	var data: String = json_result.stringify({"instructions": [instruction]})
	return DSXServer.put_packet(data.to_ascii_buffer())
