require 'rubygems'
require 'yaml'

class BloodTypes
  attr_reader :combinations

  # Fills the blood combinations with the missing set of possible blood tyoes
  #
  # @return [Hash] complete blood types combinations.
  def fill_combinations
  end

  private

  # Initializes the object loading the source file into
  #
  # @param [String] source the url of the input file.
  # @private
  def init(source)
  end

end

