class Article < ApplicationRecord
    # Added FriendlyId functionality:
    # This allows article ('event') paths to be displayed by title name
    extend FriendlyId
    friendly_id :title, use: :slugged

    belongs_to :user
    validates :title, presence: true, length: {minimum: 1, maximum: 30}
    validates :description, presence: true, length: {minimum: 1, maximum: 300}
    validates :user_id, presence: true
end
