class CreateTrashes < ActiveRecord::Migration[6.0]
  def change
    create_table :trash do |t|
      t.datetime :collected_at
      t.references :categories
      t.string :description
    end
  end
end
