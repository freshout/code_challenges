require 'rubygems'
require 'yaml'

class BloodTypes

  MIXES = {
    "A"  => ['A', 'O'],
    "B"  => ['B', 'O'],
    "AB" => ['A', 'B'],
    "O"  => ['O', 'O']
  }

  attr_reader :combinations

  def fill_combinations
    solved_combos = {}

    combinations["combinations"].each do |combo|
      solved_combos.merge! solve_combo(combo)
    end

    solved_combos
  end

  private

  def solve_combo(combo=nil)
    return if combo.nil?
    key        = combo.keys.first
    dad_type   = combo[key]["dad"]
    mom_type   = combo[key]["mom"]
    child_type = combo[key]["child"]

    if dad_type.nil? || mom_type.nil?
      return {key => solve_for_parent(split_type(dad_type), split_type(mom_type), split_type(child_type), combo[key])}
    end
    {key => solve_for_child(split_type(dad_type), split_type(mom_type), combo[key])}
  end

  def solve_for_child(dad_type, mom_type, combo)
    results = []
    rhs     = ['+','-']
    rhs     = ['-'] if dad_type.last.eql?('-') && mom_type.last.eql?('-')

    if dad_type.first == 'AB' && mom_type.first == 'O'
      combinations = MIXES[dad_type.first].combination(2).to_a
    elsif dad_type.first == 'O' && mom_type.first == 'AB'
      combinations = MIXES[mom_type.first].combination(2).to_a
    else
      combinations =  (MIXES[dad_type.first] + MIXES[mom_type.first]).combination(2).to_a
    end
    combinations.each do |combination|
      result = MIXES.find {|key, value| value == combination || value == combination.reverse}
      rhs.each {|rh| results << result.first + rh if result}
    end
    results.uniq!
    combo.merge({"child" => results.sort})
  end

  def solve_for_parent(dad_type = nil, mom_type = nil, child_type = nil, combo = nil)
    results      = []
    parent       = dad_type.nil? ? "dad" : "mom"
    if dad_type
      MIXES.each do |key, value|
        child_combinations = solve_for_child(dad_type, split_type(key + '+'), combo)["child"].each {|c| c.chop!}
        child_combinations.uniq.each do |child_combination|
          if child_combination.eql?("AB") &&
             (child_type.first.eql?("AB") || child_combination.split('').include?(child_type.first))
             results << key + '+'
             results << key + '-'
          elsif child_combination == child_type.first
            results << key + '+'
            results << key + '-'
          end
        end
      end
    else
      MIXES.each do |key, value|
        child_combinations = solve_for_child(split_type(key + '+'), mom_type, combo)["child"]
        child_combinations.each {|child_combination| child_combination.chop!}
        if child_combinations.include? child_type.first
          results << key + '+'
          results << key + '-'
        end
      end
    end
    results = results.flatten.uniq.sort
    results = "IMPOSSIBLE" if results.empty?
    combo.merge({parent => results})
  end

  def split_type(abo)
    return nil if abo.nil?
    return nil unless abo.include?('+') || abo.include?('-')
    if abo.include? '+'
      return [abo.chop, '+']
    end
    [abo.chop, '-']
  end

  def initialize(source)
    @combinations = YAML::load File.read(source)
  end

end

