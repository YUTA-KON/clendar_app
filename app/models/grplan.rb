class Grplan < ApplicationRecord
    belongs_to :group, foreign_key: :user_id
    validates :title, presence: true
end
