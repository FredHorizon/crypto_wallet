class Coin < ApplicationRecord
    belongs_to :mining_type #, 'optional :true' permite criar a tabela coins ignorando o campo mining_type, mas vai ocorrer erro nos relacionamentos. Portanto, não é recomendado.
end
