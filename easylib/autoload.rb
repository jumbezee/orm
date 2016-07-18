# require 'active_support'
# ActiveSupport::Dependencies.autoload_paths = ['./']
require 'pg'

module EasyORM
  autoload :ESTerminal, './esterminal'
  autoload :Base, './easylib/base'
  autoload :SimpleTable, './easylib/simpletable'

  #генератор путей в migrate =================================================================
  def self.autoloadgen
    table = ''
    d = Dir.new("./migrate")
    d.entries.each do |e|
      next if e =~ /^\./
      file=File.join(d.path, e)
      x = 0

      file.split(/[,_\. ]+/).each do |i|
        if x==3
          table<<i
          x += 1
        else x += 1
        end
      end
      autoload "#{table.capitalize!}", file
      table = ''
    end
  end
#=========================================================================================
 if Dir.exist?("migrate")
  EasyORM.autoloadgen
  end
#создание таблиц по файлам миграций ========================================================
  def self.create
    Base.new

    table = ''
    d = Dir.new("./migrate")
    d.entries.each do |e|
      next if e =~ /^\./
      file=File.join(d.path, e)
      x = 0

      file.split(/[,_\. ]+/).each do |i|
        if x==3
          table<<i
          x += 1
        else x += 1
        end
      end
      c = const_get("#{table.capitalize}").new
      c.change
      table = ''
    end

  end

#=========================================================================================
end

