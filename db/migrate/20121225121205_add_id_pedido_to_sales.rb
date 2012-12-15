class AddIdPedidoToSales < ActiveRecord::Migration
  def change
    add_column :sales, :id_pedido, :string
  end
end
