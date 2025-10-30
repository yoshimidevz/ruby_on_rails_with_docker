class CreateOptions < ActiveRecord::Migration[8.0]
  def change
    create_table :options do |t|
      t.references :question, null: false, foreign_key: true
      t.text :option_text, null: false
      t.boolean :is_correct, default: false, null: false

      t.timestamps
    end
    
    add_index :options, :is_correct
  end
end
