extends Object
class_name SparseMatrix

var width : int = 0
var height : int = 0
var columns : Array = []

func _init(w:int, h:int):
	width = w
	height = h
	for x in w:
		columns += [{}]

func add_value(x:int, y:int, value:float):
	var column : Dictionary = columns[x]
	assert(0 <= x and x < width)
	assert(0 <= y and y < height)
	if column.has(y):
		column[y] += value
		if abs(column[y] - 0) < 0.00000000001:
			column.erase(y)
	else:
		column[y] = value

func multiply(other:SparseMatrix) -> SparseMatrix:
	var result : SparseMatrix = get_script().new(other.width, height)
	assert(width == other.height)
	for x in other.width:
		for z in other.columns[x]:
			for y in columns[z]:
				result.add_value(x, y, other.columns[x][z] * columns[z][y])
	return result

func multiply_vector(other:StateVector) -> StateVector:
	var world_count = other.get_world_count()
	var world_vector = other.get_vector()
	var result = PoolVector2Array()
	for i in world_count:
		result.append(Vector2(0, 0))
	for z in range(world_count):
		assert abs(world_vector[z].y) < 0.000001	# SparseMatrix not complex yet
		for y in columns[z]:
			result[y] += Vector2(world_vector[z].x * columns[z][y], 0)
	return StateVector.new(result)

func print_matrix():
	print(" ")
	for i in range(columns.size()):
		var string = ""
		for j in range(columns.size()):
			if columns[j].has(i):
				string += str(stepify(columns[j][i], 0.01)) + " "
			else:
				string += "0 "
		print(string)