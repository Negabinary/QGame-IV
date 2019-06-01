extends Node

class_name WORLD_CHARACTERS

const CODE_BLOCKS = preload("res://Main/Editor/CodeBlocks/CodeBlocks.gd").CodeBlockID

enum WorldCharacters {KING, ORACLE, GUARD, CAT, BARON, ENEMY}

const ACCEPTS = [
	[CODE_BLOCKS.SWORD, CODE_BLOCKS.TIMID_SCOUT, CODE_BLOCKS.CONFIDENT_SCOUT, CODE_BLOCKS.HADAMARD],
	[CODE_BLOCKS.SWORD, CODE_BLOCKS.TIMID_SCOUT, CODE_BLOCKS.CONFIDENT_SCOUT, CODE_BLOCKS.HADAMARD, CODE_BLOCKS.CONSULT_ORACLE],
	[CODE_BLOCKS.SWORD, CODE_BLOCKS.TIMID_SCOUT, CODE_BLOCKS.CONFIDENT_SCOUT, CODE_BLOCKS.HADAMARD],
	[CODE_BLOCKS.SWORD, CODE_BLOCKS.TIMID_SCOUT, CODE_BLOCKS.CONFIDENT_SCOUT, CODE_BLOCKS.HADAMARD],
	[CODE_BLOCKS.SWORD, CODE_BLOCKS.TIMID_SCOUT, CODE_BLOCKS.CONFIDENT_SCOUT, CODE_BLOCKS.HADAMARD],
	[CODE_BLOCKS.SWORD, CODE_BLOCKS.TIMID_SCOUT, CODE_BLOCKS.CONFIDENT_SCOUT, CODE_BLOCKS.HADAMARD]
]

const ICONS = [
	preload("Headers/KingIcon.tscn"),
	preload("Headers/KingIcon.tscn"),
	preload("Headers/GuardIcon.tscn"),
	preload("Headers/CatIcon.tscn"),
	preload("Headers/BaronIcon.tscn"),
	preload("Headers/EnemyIcon.tscn")
]