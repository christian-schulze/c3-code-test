require 'csv'
require_relative 'validator'

DATA_PATH = File.expand_path(File.join(File.dirname(__FILE__), '../data'))

class C3CodeTest

  # TODO could be moved to another class, config file or database
  RULE_MAPPINGS = [
    ['warning', 'Name', 'MinimumLength', { minimum_length: 4 }],
    ['warning', 'State', 'StateExists'],
    ['warning', 'Salary', 'Integer'],
    ['error', 'Postcode', 'Exists']
  ]

  def initialize
    @validator = Validator.new
    configure_rules
  end

  def configure_rules
    RULE_MAPPINGS.each do |config|
      params = config[1..-1]
      @validator.map_column_to_rule(*params)
    end
  end

  def process_file(file_path)
    @record_index = 0
    @messages = []
    CSV.foreach(file_path, headers: true) do |row|
      process_row(row)
      @record_index += 1
    end
    @messages
  end

  def process_row(row)
    @validator.validate(row).each_with_index do |valid, index|
      next if valid

      severity = RULE_MAPPINGS[index].first
      message = @validator.mapped_rules[index].failure_message(row)

      case severity
      when 'warning'
        message = 'Warning: ' + message
      when 'error'
        message = 'Error: ' + message
      else
        raise "'severity type '#{severity}' not supported'"
      end

      @messages << "#{@record_index}: #{message}"
    end
  end

end
