class AddEmailToRegisters < ActiveRecord::Migration[6.0]
  def change
    add_column :registers, :email, :string
  end
end
