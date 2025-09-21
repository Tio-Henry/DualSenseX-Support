@tool
extends EditorPlugin


func _enter_tree() -> void:
	add_autoload_singleton("DSXRef","res://addons/dualsensex_support/api/reference.gd")
	add_autoload_singleton("DSXSys","res://addons/dualsensex_support/api/system.gd")

func _exit_tree() -> void:
	remove_autoload_singleton("DSXRef")
	remove_autoload_singleton("DSXSys")
