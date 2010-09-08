require 'blood_types'

right_answer = {
  "combination1" => {"dad" => "A+", "mom" => "B-", "child" => ["A+","A-","AB+","AB-","B+","B-","O+","O-"]},
  "combination2" => {"dad" => "O-", "mom" => ["AB+","AB-","B+","B-"], "child" => "B-"},
  "combination3" => {"dad" => "B+", "mom" => ["A+","A-","B+","B-","O+","O-"], "child" => "O+"},
  "combination4" => {"dad" => "B-", "mom" => "B+", "child" => ["B+","B-","O+","O-"]},
  "combination5" => {"dad" => "AB+", "mom" => ["A+","A-","AB+","AB-","B+","B-","O+","O-"], "child" => "A-"}
}

puts BloodTypes.new('blood_types.yml').fill_combinations == right_answer

