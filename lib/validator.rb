require_relative 'rule_mapping'

class Validator

  attr_reader :mappings

  def initialize
    @mappings = []
  end

  def map_column_to_rule(severity, column_name, klass_string, options = {})
    @mappings << RuleMapping.new(severity, column_name, klass_string, options)
  end

  def validate(row, row_index)
    [].tap do |messages|
      @mappings.each_with_index do |mapping|
        messages << build_message(row, row_index, mapping) unless mapping.rule.valid?(row)
      end
    end
  end

  def build_message(row, row_index, mapping)
    message = mapping.rule.failure_message(row)

    case mapping.severity
    when :warning
      message = 'Warning: ' + message
    when :error
      message = 'Error: ' + message
    else
      raise "'severity type '#{severity}' not supported'"
    end

    "#{row_index}: #{message}"
  end

end
