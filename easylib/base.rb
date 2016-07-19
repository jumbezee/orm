require './easylib/simple_table'
module EasyOrm
  class Base
    DATABASE_NAME = 'task'

    def initialize
      @conn = PG::Connection.new(:dbname => DATABASE_NAME)
    end

    def create_table(table_name)
      new_table = SimpleTable.new(table_name)
      yield new_table

      @conn.exec(new_table.full_table_query)
    end

    def create_column(table_name,hh)
      new_table = SimpleTable.new(table_name)

      @conn.exec(new_table.insert_query(hh))
    end

    def update_column(table_name,hh)
      new_table = SimpleTable.new(table_name)

      @conn.exec(new_table.update_column(hh))
    end

    def find_column(table_name,*arr)
      new_table = SimpleTable.new(table_name)

      @conn.exec(new_table.find_column(*arr))
    end

    def delete(table_name,hh)
      new_table = SimpleTable.new(table_name)

      @conn.exec(new_table.delete_column(hh))
    end
  end
end
