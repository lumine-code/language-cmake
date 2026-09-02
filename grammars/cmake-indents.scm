; Every block command opens with `(` on its own line and closes with a
; matching `end*` command, so the block keywords drive the indent rather than
; the parentheses, which open and close on the same line.
[
  (function)
  (macro)
  (if)
  (elseif)
  (else)
  (foreach)
  (while)
] @indent

[
  (endfunction)
  (endmacro)
  (endif)
  (elseif)
  (else)
  (endforeach)
  (endwhile)
] @dedent
