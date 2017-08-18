class CreateGraduates < ActiveRecord::Migration[5.0]
  def change
    create_table :graduates do |t|
      t.string :name

      t.timestamps
    end
  end
end
