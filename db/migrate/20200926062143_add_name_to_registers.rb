class AddNameToRegisters < ActiveRecord::Migration[6.0]
  def change
    add_column :registers, :name, :string
  end
end
