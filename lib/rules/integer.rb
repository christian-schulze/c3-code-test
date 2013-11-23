
module Rules
  class Integer

    def initialize(column_name, options = {})
      @column_name = column_name
    end

    def valid?(row)
      return false unless row.has_key?(@column_name)

      integer?(row[@column_name])
    end

    private

    def integer?(value)
      value =~ /^[-+]?\d+$/
    end

  end
end
