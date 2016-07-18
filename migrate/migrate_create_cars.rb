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
