class CreateHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :histories do |t|
      t.jsonb :board, null: false, default: {}
      t.jsonb :board_path, null: false, default: {}
      t.string :answer

      t.timestamps
    end
  end
end
