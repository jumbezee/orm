require './easylib/autoload'
class ESTerminal

#===================================================================================
  def self.update_migrate
    #считываем директорию с миграциями
      table = ''
      d = Dir.new("./migrate")
      d.entries.each do |e|
        next if e =~ /^\./
        file=File.join(d.path, e)
        #меняем migrate по названию
        x = 0

        file.split(/[,_\. ]+/).each do |i|
          if x==3
            table<<i
            x += 1
          else x += 1
          end
        end
        f = File.write(file, "
class #{table.capitalize}<Base
  def change
    create_table :#{table} do |t|

    end
  end
end")
      table = ''
      end
  end
#========================================================================================
#КОМАНДЫ EasyORM=========================================================================
  loop do
  print "Введите команду: "
  command = gets.strip
    case command
      when 'dbc', 'db create'
        EasyORM.create
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
        ESTerminal.update_migrate
      when 'help', 'dbh'
        puts 'dbn:                Create a new database migrate files'
        puts 'dbu:                Update migrate files'
        puts 'dbc:                Create tables for database'

    end
  command = ''
  end


end



