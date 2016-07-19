require 'pg'

module EasyOrm
  autoload :ESTerminal, './esterminal'
  autoload :Base, './easylib/base'
  autoload :SimpleTable, './easylib/simple_table'

  def self.generate_path
    @hh = {}
    d = Dir.new("./migrate")
    d.entries.each do |e|
      next if e =~ /^\./
      file=File.join(d.path, e)
      x = 0

      file.split(/[,_\. ]+/).each do |i|
        if x==3
          @hh[i] = file
          x += 1
        else x += 1
        end
      end
    end
  end

  def self.gen_for_autoload
      generate_path
      @hh.each do |key,value|
        autoload "#{key.capitalize}", value
      end
  end

  if Dir.exist?("migrate")
    gen_for_autoload
  end

  def self.create_db
      generate_path
      @hh.each do |key,value|
        c = const_get("#{key.capitalize}").new
        c.change
      end
  end

  def self.update_migrate
    generate_path
    @hh.each do |key,value|
      File.write(value, "
class #{key.capitalize}<EasyOrm::Base
  def change
    create_table :#{key} do |t|

    end
  end
end")
    end
  end
  def self.create_column(table_name,hh)
    c = Base.new
    c.create_column(table_name, hh)
  end

  def self.update_column(table_name,hh)
    c = Base.new
    c.update_column(table_name,hh)
  end

  def self.find_column(table_name,*arr)
    c = Base.new
    c.find_column(table_name,*arr)
  end

  def self.delete(table_name,hh)
    c = Base.new
    c.delete(table_name,hh)
  end
end

