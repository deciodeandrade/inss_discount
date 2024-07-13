class CreateProponents < ActiveRecord::Migration[7.0]
  def change
    create_table :proponents do |t|
      t.string :name
      t.string :cpf
      t.date :birth_date
      t.decimal :salary
      t.string :personal_contact
      t.string :reference_contact

      t.timestamps
    end
  end
end
