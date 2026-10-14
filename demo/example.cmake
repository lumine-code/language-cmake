cmake_minimum_required(VERSION 3.20)

set(GREETING "hello")

function(my_helper ARG)

  message(STATUS ${ARG})

endfunction()

# a line comment
