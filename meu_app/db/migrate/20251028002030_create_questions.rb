class CreateQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :questions do |t|
      t.references :quiz, null: false, foreign_key: true
      t.text :question_text, null: false
      t.string :question_type, default: 'multiple_choice', null: false
      t.integer :points, default: 1, null: false

      t.timestamps
    end
    
    add_index :questions, :question_type
  end
end
