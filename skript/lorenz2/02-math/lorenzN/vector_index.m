# No need to add the index offset since we are skipping order 0
# vector index in the matrix:
# 0, 1, 3,
# 2, 4,
# 5, 
function ret = vector_index(alpha1, alpha2, basic_offset)
  order = abs(alpha1 + alpha2);
  offset = order * (order + 1) / 2;
  ret = basic_offset + offset + alpha1;
endfunction