class AddMiningTypeToCoins < ActiveRecord::Migration[5.2]
  def change
    add_reference :coins, :mining_type, foreign_key: true # Semântica: adiciona_referência à tabela :coins, por meio do campo :mining_type, que será chave_estrangeira: ok
  end
end
