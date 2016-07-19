  class SimpleTable
    COLUMN_TYPES = [ :boolean, :integer, :text ]

    attr_reader :table_query, :table_name

    COLUMN_TYPES.each do |type|
      define_method "#{type}" do |*args|
        case args.size
          when 1
          @table_query << "#{args[0]} #{type},"
          when 2
            bb=[]
            args[1].each do |key|
              bb=key
            end
            @table_query << "#{args[0]} #{type} #{bb[0]} #{bb[1]},"
        end
      end
    end

    def initialize(table_name)
      @table_name = table_name
      @table_query = "CREATE TABLE #{table_name} ("
    end

    def full_table_query
      drop_table_query! + "#{table_query.chomp(',')});"
    end

    def drop_table_query!
      "DROP TABLE IF EXISTS #{table_name};"
    end
  end
