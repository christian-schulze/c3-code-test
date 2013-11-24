require_relative 'rules/exists'
require_relative 'rules/integer'
require_relative 'rules/minimum_length'
require_relative 'rules/state_exists'

class RuleMapping

  attr_reader :column_name, :rule, :options

  def initialize(column_name, klass_string, options = {})
    @column_name, @klass_string, @options = column_name, klass_string, options

    @rule = self.class.string_to_klass(klass_string).new(column_name, options)
  end

  def self.string_to_klass(klass_string)
    Rules.const_get(klass_string)
  end

end
