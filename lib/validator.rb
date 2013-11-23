require_relative 'rules/exists'
require_relative 'rules/integer'
require_relative 'rules/minimum_length'
require_relative 'rules/state_exists'

class Validator

  attr_reader :mapped_rules

  def initialize
    @mapped_rules = []
  end

  def map_column_to_rule(column_name, klass_string, options = {})
    @mapped_rules << self.class.string_to_klass(klass_string).new(column_name, options)
  end

  def validate(row)
    @mapped_rules.map do |rule|
      rule.valid?(row)
    end
  end

  def self.string_to_klass(klass_string)
    Rules.const_get(klass_string)
  end

end
