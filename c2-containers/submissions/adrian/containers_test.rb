require 'containers'

stacks = {
  "case_1" => 1,
  "case_2" => 3,
  "case_3" => 1,
  "case_4" => 4,
  "case_5" => 2,
  "case_6" => 2,
  "case_7" => 7,
  "case_8" => 8,
  "case_9" => 1
}

puts SeaportTerminal.new('containers.in').stack_containers.inspect

puts SeaportTerminal.new('containers.in').stack_containers == stacks

