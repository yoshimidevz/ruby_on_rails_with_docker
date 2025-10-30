class CreateAnswers < ActiveRecord::Migration[8.0]
  def change
    create_table :answers do |t|
      t.references :admin, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.references :option, null: false, foreign_key: true
      t.references :quiz, null: false, foreign_key: true

      t.timestamps
    end
    
    add_index :answers, [:admin_id, :quiz_id]
    add_index :answers, [:question_id, :admin_id], unique: true
  end
end
