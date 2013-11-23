require_relative '../c3_code_test'
require 'csv'

module Rules
  class StateExists

    def initialize(column_name, options = {})
      @column_name= column_name
      @data_path = options.fetch(:default_path, File.join(::DATA_PATH, 'states.csv'))

      load_states_data
    end

    def valid?(row)
      return false unless row.has_key?(@column_name)

      include_state_index?(row[@column_name])
    end

    def failure_message(row)
      "#{@column_name}: #{row[@column_name]} is not contained in the states list."
    end

    private

    def load_states_data
      states = CSV.read(@data_path, row_sep: "\r\r\n")
      @states = states.map(&:first)
    end

    def include_state_index?(value)
      @states.include?(value)
    end
  end
end
