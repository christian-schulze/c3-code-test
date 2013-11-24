require 'csv'
require_relative 'validator'

DATA_PATH = File.expand_path(File.join(File.dirname(__FILE__), '../data'))

class C3CodeTest

  # TODO could be moved to another class, config file or database
  RULE_MAPPINGS = [
    [:warning,  'Name',     'MinimumLength', { minimum_length: 4 }],
    [:warning,  'State',    'StateExists'],
    [:warning,  'Salary',   'Integer'],
    [:error,    'Postcode', 'Exists']
  ]

  def initialize
    @validator = Validator.new
    configure_rules
  end

  def configure_rules
    RULE_MAPPINGS.each do |params|
      @validator.map_column_to_rule(*params)
    end
  end

  def process_file(file_path)
    messages, record_index = [], 0

    CSV.foreach(file_path, headers: true) do |row|
      messages += process_row(row, record_index)
      record_index += 1
    end

    messages
  end

  def process_row(row, record_index)
    @validator.validate(row, record_index)
  end

end
