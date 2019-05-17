class Coin < ApplicationRecord
    belongs_to :mining_type # esse campo(mining_type), essa fk, pertence_a(belongs_to) tabela mining_types
end
