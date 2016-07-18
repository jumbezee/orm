# require 'active_support'
# ActiveSupport::Dependencies.autoload_paths = ['./']
require 'pg'

module EasyORM
  autoload :ESTerminal, './ormterminal'
  autoload :Base, './base'
  autoload :Cars, './migrate/migrate_create_cars'
  autoload :SimpleTable, './simpletable'


  def self.create
    Base.new
    c = Cars.new
    c.change
  end

end

