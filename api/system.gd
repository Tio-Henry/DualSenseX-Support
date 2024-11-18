extends Node

var DSXServer : PacketPeerUDP = PacketPeerUDP.new()

func _ready() -> void:
	var json_result: JSON = JSON.new()
	var data: = json_result.stringify({"instructions":[{"type":DSXRef.InstructionType.TriggerUpdate,"parameters":[0,1,22,2,6,8]}]})
	DSXServer.connect_to_host("127.0.0.1",6969)
	DSXServer.put_packet(data.to_ascii_buffer())

func Trigger(packet: DSXRef.Packet,):
	pass
