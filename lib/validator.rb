require_relative 'rule_mapping'

class Validator

  attr_reader :mappings

  def initialize
    @mappings = []
  end

  def map_column_to_rule(severity, column_name, klass_string, options = {})
    @mappings << RuleMapping.new(severity, column_name, klass_string, options)
  end

  def validate(row)
    @mappings.map do |mapping|
      mapping.rule.valid?(row)
    end
  end

end
