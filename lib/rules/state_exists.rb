require 'csv'

module Rules
  class StateExists

    DEFAULT_DATA_PATH = File.expand_path(File.join(File.dirname(__FILE__), 'data/states.csv'))

    def initialize(column_name, data_path = DEFAULT_DATA_PATH)
      @column_name, @data_path = column_name, data_path
      load_states_data
    end

    def valid?(row)
      return false unless row.has_key?(@column_name)

      include_state_index?(row[@column_name])
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
