extends Node

const CodeBlocks = preload("res://Enums/CodeBlocks.gd").CodeBlocks

enum WorldCharacters {KING, ORACLE, GUARD, CAT, BARON, ENEMY}

const ACCEPTS = [
	[CodeBlocks.SWORD, CodeBlocks.TIMID_SCOUT, CodeBlocks.CONFIDENT_SCOUT, CodeBlocks.HADAMARD],
	[CodeBlocks.SWORD, CodeBlocks.TIMID_SCOUT, CodeBlocks.CONFIDENT_SCOUT, CodeBlocks.HADAMARD, CodeBlocks.CONSULT_ORACLE],
	[CodeBlocks.SWORD, CodeBlocks.TIMID_SCOUT, CodeBlocks.CONFIDENT_SCOUT, CodeBlocks.HADAMARD],
	[CodeBlocks.SWORD, CodeBlocks.TIMID_SCOUT, CodeBlocks.CONFIDENT_SCOUT, CodeBlocks.HADAMARD],
	[CodeBlocks.SWORD, CodeBlocks.TIMID_SCOUT, CodeBlocks.CONFIDENT_SCOUT, CodeBlocks.HADAMARD],
	[CodeBlocks.SWORD, CodeBlocks.TIMID_SCOUT, CodeBlocks.CONFIDENT_SCOUT, CodeBlocks.HADAMARD]
]

const ICONS = [
	preload("res://CodingUI/CodeArea/Headers/KingIcon.tscn"),
	preload("res://CodingUI/CodeArea/Headers/KingIcon.tscn"),
	preload("res://CodingUI/CodeArea/Headers/GuardIcon.tscn"),
	preload("res://CodingUI/CodeArea/Headers/CatIcon.tscn"),
	preload("res://CodingUI/CodeArea/Headers/BaronIcon.tscn"),
	preload("res://CodingUI/CodeArea/Headers/EnemyIcon.tscn")
]