class Album < ApplicationRecord
    belongs_to :user, foreign_key: "user_id"
    validates :title, presence: true
    validates :decription, presence: true
    has_many_attached :album_photos , dependent: :destroy
end
