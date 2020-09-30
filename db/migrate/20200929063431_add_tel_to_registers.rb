class AddTelToRegisters < ActiveRecord::Migration[6.0]
  def change
    add_column :registers, :tel, :string
  end
end
