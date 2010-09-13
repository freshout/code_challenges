class BloodTypes
  BLOODS_ABO = ["A-", "B-", "AB-", "O-", "A+", "B+", "AB+", "O+"]

  attr_reader :combinations

  # Fills the blood combinations with the missing set of possible blood tyoes
  #
  # @return [Hash] complete blood types combinations.
  def fill_combinations
    @filled_combinations = { }

    @combinations.each do |family|
      family.each do |name, members|
        @filled_combinations[name] = fill_missing_member(members)
      end
    end

    @filled_combinations
  end

  private
  def fill_missing_member(members)
    if members["child"].nil?
      fill_missing_child(members)
    elsif members["mom"].nil?
      fill_missing_parent(members, "mom")
    else
      fill_missing_parent(members, "dad")
    end

    members
  end

  def fill_missing_child(members)
    dad_blood = Blood.new(members["dad"])
    mom_blood = Blood.new(members["mom"])
    members["child"] = (dad_blood + mom_blood).possibles

    members
  end

  def fill_missing_parent(members, missing_parent)
    if missing_parent == "dad"
      known_parent = "mom"
    else
      known_parent = "dad"
    end

    known_parent_blood = Blood.new(members[known_parent])
    posible_parent_blood = []
    BLOODS_ABO.each do |b|
      some_blood = Blood.new(b)
      if (some_blood + known_parent_blood).to_a.include?(members["child"])
        posible_parent_blood << b
      end
    end
    unless posible_parent_blood.empty?
      members[missing_parent] = posible_parent_blood.sort
    else
      members[missing_parent] = "IMPOSSIBLE"
    end

  end

  def mix_blood(dad_blood, mom_blood)
    dad_posible_ABO = get_posible_ABO(blood)
  end

  def get_posible_ABO(blood)
    the_ABO, the_RH = blood.match(/(\w+)(\+|-)/).to_a.slice(1,2)
    POSIBLE_ABO[the_ABO]
  end
  # Initializes the object loading the source file into
  #
  # @param [String] source the url of the input file.
  # @private
  def initialize(source)
    @combinations = YAML.load_file(source)["combinations"]
  end

end


# I think is better to say that we inherit or blood from our grandparents
class Blood

  attr_accessor :rh

  def set_blood_type(blood_str)
    @the_ABO, @the_RH = blood_str.match(/(\w+)(\+|-)/).to_a.slice(1,2)

    case @the_ABO
    when "A"
      @blood["A"] = true
      @blood["O"] = true
    when "B"
      @blood["B"] = true
      @blood["O"] = true
    when "AB"
      @blood["A"] = true
      @blood["B"] = true
    when "O"
      @blood["O"] = true
    end

    @the_RH == "+" ? @rh = true : @rh = false
  end

  def initialize(blood_str = nil)
    @blood = {}
    @rh = nil

    set_blood_type(blood_str) unless blood_str.nil?
  end

  def +(other)
    mix_blood(self, other)
  end

  def possibles
    bloods = self.to_a
    if bloods.empty?
      return "IMPOSSIBLE"
    else
      return bloods
    end
  end

  def to_a
    posible_abo = @blood.keys
    # blood can be rh negative every time, but positive can't be
    posible_blood = posible_abo.collect { |b| b + "-"}
    # if can be rh positive add
    if @rh == true
      posible_blood += posible_abo.collect { |b| b + "+"}
    end

    posible_blood.sort
  end

  protected
  def blood
    @blood
  end

  def [](abo)
    @blood[abo]
  end

  def []=(abo, val)
    @blood[abo] = val
  end

  private
  # use boolean math to solve the mixes
  def mix_blood(p1, p2)
    new_blood = Blood.new()
    new_blood["O"] = true if (p1["O"] && p2["O"])
    new_blood["A"] = true if (p1["O"] && p2["A"]) || (p1["A"] && p2["O"]) || (p1["A"] && p2["A"])
    new_blood["B"] = true if (p1["O"] && p2["B"]) || (p1["B"] && p2["O"]) || (p1["B"] && p2["B"])
    new_blood["AB"] = true if (p1["A"] && p2["B"]) || (p1["B"] && p2["A"])
    new_blood.rh = p1.rh || p2.rh

    new_blood
  end
end

