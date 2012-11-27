class AddWithdrawFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :withdraw_option, :integer

    add_column :users, :withdraw_bank_cpf,      :string
    add_column :users, :withdraw_bank_account,  :string
    add_column :users, :withdraw_bank_agency,   :string
    add_column :users, :withdraw_bank_number,   :string
    add_column :users, :withdraw_bank_name,     :string

    add_column :users, :withdraw_digital_cpf,   :string
    add_column :users, :withdraw_digital_email, :string
    add_column :users, :withdraw_digital_name,  :string

    add_column :users, :withdraw_remember, :boolean, default: true
  end
end
