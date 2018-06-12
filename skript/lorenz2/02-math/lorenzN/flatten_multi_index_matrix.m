function ret = flatten_multi_index_matrix(M, order)
  index_offset = 1;
  idx = 1;
  for k = 1:order
    for alpha1 = 0:k
      alpha2 = k - alpha1;
      ret(idx++) = M(alpha1 + index_offset, alpha2 + index_offset);
    endfor
  endfor
endfunction