require './easylib/autoload'
class ESTerminal
  print "Введите команду: "
  command = gets.strip

  case command
    when 'dbc', 'db create'
      EasyORM.create
  end

end



