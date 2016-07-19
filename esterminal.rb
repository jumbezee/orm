require './easylib/autoload'
class ESTerminal

  loop do
  print "Введите команду: "
  command = gets.strip
    case command
      when 'dbc', 'db create'
        EasyOrm.create_db
      when 'dbn', 'db new'
        if Dir.exists?("migrate")
          Dir.chdir("migrate") do
            File.new("#{Time.now.to_i}_file.rb", "w")
          end
        else
          Dir.mkdir("migrate")
          Dir.chdir("migrate") do
            File.new("#{Time.now.to_i}_file.rb", "w")
          end
        end
      when 'dbu', 'db update'
        EasyOrm.update_migrate

      #Create column
      when 'ccn'
                    #INSERT INTO cars(name, speed) VALUES('audi', 250)
        EasyOrm.create_column('cars',name: 'audi', speed: 250)

        # Update column
      when 'updc'
                    #UPDATE cars SET speed = 400 WHERE name = 'audi'
        EasyOrm.update_column('cars',speed: 400, where: '',name: 'audi')

      #Find column
      when 'find'
                    #SELECT * FROM cars;
        EasyOrm.find_column('cars',:*)

      #Delete column
      when 'delete'
                    #DELETE FROM cars WHERE name = 'audi'
        EasyOrm.delete('cars',name: 'audi')

      when 'help', 'dbh'
        puts 'dbn:                Create a new database migrate files'
        puts 'dbu:                Update migrate files'
        puts 'dbc:                Create tables for database'
        puts 'ccn:                Create column'
        puts 'updc:               Update column'
        puts 'find:               Find column'
        puts 'delete:             Delete column'
        puts 'exit:               Type for exit'
      when 'exit'
        exit

    end
  command = ''
  end


end



