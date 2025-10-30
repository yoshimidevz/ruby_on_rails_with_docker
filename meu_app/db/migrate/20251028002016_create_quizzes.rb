class CreateQuizzes < ActiveRecord::Migration[8.0]
  def change
    create_table :quizzes do |t|
      t.string :title, null: false
      t.text :description
      t.references :admin, null: false, foreign_key: true
      t.string :status, default: 'draft', null: false

      t.timestamps
    end
    
    add_index :quizzes, :status
  end
end
