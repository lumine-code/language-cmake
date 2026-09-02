; Functions and macros are the definitions worth navigating to; a CMake
; project has no other named scope.
(function_def
  (function_command
    (argument_list
      . (argument) @name))) @definition.function

(macro_def
  (macro_command
    (argument_list
      . (argument) @name))) @definition.function
