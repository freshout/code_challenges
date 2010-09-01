require 'blood_types'

right_answer = {
  "combination1" => {"dad" => "A+", "mom" => "B-", "child" => "AB+"},
  "combination2" => {"dad" => "O-", "mom" => "B-", "child" => "B-"},
  "combination3" => {"dad" => "B+", "mom" => "B-", "child" => "O+"},
  "combination4" => {"dad" => "B-", "mom" => "B+", "child" => ["B+","O+"]},
  "combination5" => {"dad" => "AB+", "mom" => "IMPOSSIBLE", "child" => "A-"},
}

puts BloodTypes.new('blood_types.yml').fill_combinations == right_answer

