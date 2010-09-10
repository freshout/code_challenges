require 'containers'

stacks = {
  "case_1" => 1,
  "case_2" => 3,
  "case_3" => 1,
  "case_4" => 4,
}


puts SeaportTerminal.new('containers.in').stack_containers == stacks

