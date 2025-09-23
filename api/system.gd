extends Node

var DSXServer: PacketPeerUDP = PacketPeerUDP.new()

func _enter_tree() -> void:
	DSXRef.process_thread_group = Node.PROCESS_THREAD_GROUP_SUB_THREAD
	process_thread_group = Node.PROCESS_THREAD_GROUP_SUB_THREAD
	connect_to("127.0.0.1",6971)

func _exit_tree() -> void:
	reset_settings(0)

func _ready() -> void:
	led(0, Color(0.733, 0.0, 0.537, 1.0),25)
	mic_led(0, DSXRef.MicLED.ON)
	print(get_dsx_info())

func connect_to(ip: String, port: int) -> Error:
	return DSXServer.connect_to_host(ip, port)

func get_dsx_info() -> String:
	send_data({"type":DSXRef.InstructionType.GetDSXStatus})
	var data: String = ""
	if DSXServer.is_socket_connected():
		while data == "":
			data = DSXServer.get_packet().get_string_from_ascii()
		return data
	else:
		return ""

func adaptive_trigger(device: int, trigger: DSXRef.Trigger, trigger_mode: DSXRef.TriggerMode) -> void:
	send_data({"type":DSXRef.InstructionType.TriggerUpdate,"parameters":[device,trigger,trigger_mode,2,6,8]})
	
func led(device: int, color: Color, brightness: int) -> void:
	send_data({"type":DSXRef.InstructionType.RGBUpdate,"parameters":[device, color.r8, color.g8, color.b8, brightness]})

func mic_led(device: int, state: DSXRef.MicLED) -> void:
	send_data({"type":DSXRef.InstructionType.MicLED,"parameters":[device, state]})
	
func send_data(instruction: Dictionary) -> void:
	var json_result: JSON = JSON.new()
	var data: String = json_result.stringify({"instructions":[instruction]})
	DSXServer.put_packet(data.to_ascii_buffer())

func reset_settings(device: int) -> void:
	send_data({"type": DSXRef.InstructionType.ResetToUserSettings,"parameters": [device]})
