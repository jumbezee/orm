require './easylib/simpletable'
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
end
