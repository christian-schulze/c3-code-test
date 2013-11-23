
module Rules
  class Exists

    def initialize(column_name, options = {})
      @column_name = column_name
    end

    def valid?(row)
      return false unless row.has_key?(@column_name)

      row[@column_name].length > 0
    end

  end
end
