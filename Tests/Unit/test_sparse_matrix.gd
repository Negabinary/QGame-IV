extends "res://addons/gut/test.gd"

func test_add_item():
	var sparse_matrix = SparseMatrix.new(4,4)
	assert_eq(
			sparse_matrix.columns.hash(),
			[{}, {}, {}, {}].hash())
	sparse_matrix.add_value(1,2,sqrt(2))
	assert_eq(
			sparse_matrix.columns.hash(),
			[{}, {2:sqrt(2)}, {}, {}].hash())
	sparse_matrix.add_value(1,2,-sqrt(2))
	assert_eq(
			sparse_matrix.columns.hash(),
			[{}, {}, {}, {}].hash())

func test_multiply():
	var matrix_a = SparseMatrix.new(3, 2)
	var matrix_b = SparseMatrix.new(2, 3)
	matrix_a.columns = [{0:1}, {1:2}, {0:3, 1:4}]
	matrix_b.columns = [{0:5, 1:6}, {2:7}]
	var matrix_c = matrix_a.multiply(matrix_b)
	assert_eq(
			matrix_c.columns.hash(),
			[{0:5.0, 1:12.0}, {0:21.0, 1:28.0}].hash(),
			str(matrix_c.columns))

func test_hadamard():
	var matrix_h = GateBuilder.new_hadamard(2, 0, [0,1])
	var matrix_i = matrix_h.multiply(matrix_h)
	assert_eq(
			str(matrix_i.columns),
			str([{0:1.0}, {1:1.0}]),		#I know this is bad but str works and hash doesn't
			str(matrix_i.columns))

func test_multiply_vector():
	var vector = StateVector.new([Vector2(1, 0), Vector2(2, 0), Vector2(3, 0)])
	var matrix = SparseMatrix.new(3, 3)
	matrix.columns = [{1:1, 2:2}, {1:2}, {}]
	var result = matrix.multiply_vector(vector)
	assert_eq(
			result.vector,
			PoolVector2Array([Vector2(0,0), Vector2(5,0), Vector2(2,0)])
			)