require 'blood_types'

right_answer = {
  "combination0" => {"dad" => "O-", "mom" => ["A+","A-","B+","B-","O+","O-"], "child" => "O-"},
  "combination1" => {"dad" => "A+", "mom" => "B-", "child" => ["A+","A-","AB+","AB-","B+","B-","O+","O-"]},
  "combination2" => {"dad" => "O-", "mom" => ["AB+","AB-","B+","B-"], "child" => "B-"},
  "combination3" => {"dad" => ["A+","A-","B+","B-","O+","O-"], "mom" => "B-", "child" => "O+"},
  "combination4" => {"dad" => "B-", "mom" => "B+", "child" => ["B+","B-","O+","O-"]},
  "combination5" => {"dad" => "AB+", "mom" => ["A+","A-","AB+","AB-","B+","B-","O+","O-"], "child" => "A-"},
  "combination6" => {"dad" => "AB-", "mom" => "IMPOSSIBLE", "child" => "O-"},
  "combination7" => {"dad" => "AB+", "mom" => "B+", "child" => ["A+","A-","AB+","AB-","B+","B-"]},
  "combination8" => {"dad" => "O+", "mom" => "O+", "child" => ["O+","O-"]},
  "combination9" => {"dad" => "O-", "mom" => "O-", "child" => ["O-"]}
}
puts BloodTypes.new('blood_types.yml').fill_combinations == right_answer

