
  class SimpleTable
    COLUMN_TYPES = [ :boolean, :integer, :text ]

    attr_reader :table_query, :table_name, :add_column_key, :add_column_value, :add_column
    attr_reader :upd_column, :upd_column_set, :upd_column_where
    attr_reader :f_column_select, :f_column_from, :f_column, :d_c_key, :d_c_value, :d_column

    COLUMN_TYPES.each do |type|
      define_method "#{type}" do |*args|
        if args.size == 1
          @table_query << "#{args[0]} #{type},"
          else if args.size == 2
            bb=[]
            args[1].each do |key|
              bb=key
            end
            @table_query << "#{args[0]} #{type} #{bb[0]} #{bb[1]},"
        end
      end
      end
    end


    def initialize(table_name)
      @table_name = table_name
      @table_query = "CREATE TABLE #{table_name} ("

      @add_column_key = "INSERT INTO #{table_name}("
      @add_column_value = " VALUES('"

      @upd_column_set = "UPDATE #{table_name} SET "
      @upd_column_where = " WHERE "

      @f_column_select = "SELECT "
      @f_column_from = " FROM #{table_name}"

      @d_c_key = "DELETE FROM #{table_name} "
      @d_c_value = " WHERE "
    end

    def full_table_query
      drop_table_query! + "#{table_query.chomp(',')});"
    end

    def drop_table_query!
      "DROP TABLE IF EXISTS #{table_name};"
    end

    def insert_query(hh)
      x = hh.size
      hh.each do |key,value|
        @add_column_key<<"#{key}"
        @add_column_value<<"#{value}'"
        if x>1
          @add_column_key<<", "
          @add_column_value<<", '"
          x -= 1
        end
      end
      @add_column = @add_column_key + ")" + @add_column_value + ");"
    end

    def update_column(hh)
      @fl = 0
      x = hh.size
      hh.each do |key,value|
        if key.to_s == 'where'
          @fl = 1
          next if key.to_s == 'where'
        end
        if @fl == 0
          @upd_column_set<<"#{key} = '"
          @upd_column_set<<"#{value}'"
        elsif @fl == 1
          @upd_column_where<<"#{key} = '"
          @upd_column_where<<"#{value}'"
        end
        if x>3
          @upd_column_set<<", "
          @upd_column_where<< " AND "
          x -= 1
        end

      end
      @upd_column = @upd_column_set + @upd_column_where + ";"
    end

    def find_column(*arr)
      x = arr.size
      arr.each do |arr|
        @f_column_select<<"#{arr}"
        if x>1
          @f_column_select<<", "
          x -= 1
        end
      end
      @f_column = @f_column_select + @f_column_from + ";"
      # puts @f_column
      # return @f_column
    end

    def delete_column(hh)
      hh.each do |key,value|
        @d_c_value<<"#{key} = '"
        @d_c_value<<"#{value}'"
      end
      @d_column = @d_c_key + @d_c_value + ";"
    end
  end
