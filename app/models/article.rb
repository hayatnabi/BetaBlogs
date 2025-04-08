class Article < ApplicationRecord
  validates :title, presence: true, length: {minimum: 8, maximum: 12}
  validates :description, presence: true, length: {minimum: 8, maximum: 100}
end
