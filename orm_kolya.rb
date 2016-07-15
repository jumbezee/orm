require 'pg'

class Base
    # NATIVE_DATABASE_TYPES = {
    #     text:        { name: "text" }
    # }
    def initialize
      @conn = PG::Connection.new( :dbname => 'task')
    end


      def create_table(table_name, options= {})

          change do |t|
            yield t
          end


          # create = "CREATE TABLE #{table_name} (#{a});"
          # @conn.exec(create)


        # create = "CREATE TABLE #{table_name} ();"
        # @conn.exec(create)
      end
    end



# def hashhhh(hh)
#   @arr = []
#   @arr1 = []
#   @arr2 = []
#   hh.each do |line|
#     @arr<<line[0]
#     @arr1<<line[1]
#     @arr = "#{@arr1} #{@arr2}"
#   end
#   print @arr
# end
#
#
# hashhhh(name: varchar(80) ,age: integer)




class CreateCars < Base
  def change
    create_table :cars do |t|
      t.text :name
      t.text :model
    end
  end

end

c = CreateCars.new
c.change


