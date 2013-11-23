
module Rules
  class Exists

    def initialize(column_name, options = {})
      @column_name = column_name
    end

    def valid?(row)
      return false unless row.has_key?(@column_name)
      return false if row[@column_name].nil?

      row[@column_name].length > 0
    end

    def failure_message(row)
      "#{@column_name} does not exist."
    end

  end
end
