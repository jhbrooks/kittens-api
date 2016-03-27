class CreateKittens < ActiveRecord::Migration
  def change
    create_table :kittens do |t|
      t.string :name
      t.decimal :age
      t.decimal :cuteness
      t.decimal :softness

      t.timestamps null: false
    end
  end
end
