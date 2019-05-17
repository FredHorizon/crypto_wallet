class MiningType < ApplicationRecord
    has_many :coins # um tipo de mineração pode ter várias coins
end
