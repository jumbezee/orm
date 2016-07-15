require 'pg'

module TableImage

  class SimpleTable
    COLUMN_TYPES = [ :boolean, :integer, :text ]

    attr_reader :table_query, :table_name

    COLUMN_TYPES.each do |type|
      define_method "#{type}" do |attr|
        @table_query << "#{attr} #{type},"
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

end


class Base
  include TableImage

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


class CreateCars < Base
  def change
    create_table :cars do |t|
      t.integer :max_speed
      t.text :description
      t.text :name
      t.text :model
      t.boolean :is_stock
    end
  end

end

c = CreateCars.new
c.change

