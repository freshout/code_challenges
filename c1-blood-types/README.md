Blood Types
===========

__Note:__This code challenge was taken from the ACM International Collegiate Programming Contest 2007 and modified to fit in this challenge

__Language:__Ruby
__Allowed gems:__yaml
### Introduction
Every person’s blood has 2 markers called ABO alleles. Each of the markers is represented by one of three
letters: A, B, or O. This gives six possible combinations of these alleles that a person can have, each of them
resulting in a particular ABO blood type for that person.

__Combination ABO Blood Type__

1.  A  A  A
2.  A  B  AB
3.  A  O  A
4.  B  B  B
5.  B  O  B
6.  O  O  O

Likewise, every person has two alleles for the blood Rh factor, represented by the characters + and -. Someone
who is “Rh positive” or “Rh+” has at least one + allele, but could have two. Someone who is “Rh negative”
always has two – alleles.

The blood type of a person is a combination of ABO blood type and Rh factor. The blood type is written by
suffixing the ABO blood type with the + or - representing the Rh factor. Examples include A+, AB-, and O-.
Blood types are inherited: each biological parent donates one ABO allele (randomly chosen from their two) and
one Rh factor allele to their child. Therefore 2 ABO alleles and 2 Rh factor alleles of the parents determine the
child’s blood type. For example, if both parents of a child have blood type A-, then the child could have either
type A- or type O- blood. A child of parents with blood types A+ and B+ could have any blood type.
In this problem, you will be given the blood type of either both parents or one parent and a child; you will then
determine the (possibly empty) set of blood types that might characterize the child or the other parent.

__Note:__an uppercase letter “Oh” is used in this problem to denote blood types, not a digit (zero).


### Input
A Yaml file blood_types.yml included in the folder. You should load this file into a hash

### Output
A hash with all the combinations given filled with the missing set of possible types, if the combination is impossible
return the IMPOSSIBLE keyword.

### Example

__input__<br />
combination1 = dad A+, mom O-<br />
combination2 = mom B+, child O+<br />
combination3 = dad A+, child O-<br />
__output__<br />
combinations = {<br />
  "combination1" => {"dad" => "A+", "mom" => "O-", "child" => ["A+", "A-", "O+", "O-"]},<br />
  "combination2" => {"dad" => ["O+", "O-"], "mom" => "B+", "child" => "O+"}<br />
  "combination3" => {"dad" => "A+", "mom" => ["A-","B-","O-"], "child" => "O-"}<br />
}

