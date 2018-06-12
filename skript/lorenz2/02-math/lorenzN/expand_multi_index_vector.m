function ret = expand_multi_index_vector(V, order, basic_offset)
  index_offset = 1;
  ret = zeros(order);
  for k = 1:order
    for alpha1 = 0:k
      alpha2 = k - alpha1;
      ret(alpha1 + index_offset, alpha2 + index_offset) = V(vector_index(alpha1, alpha2, basic_offset));
    endfor
  endfor
endfunction