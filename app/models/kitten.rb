class Kitten < ActiveRecord::Base
  validates :name, presence: true
  validates :age, presence: true,
                  numericality: { greater_than_or_equal_to: 0 }
  validates :cuteness, presence: true,
                       numericality: { greater_than_or_equal_to: 1,
                                       less_than_or_equal_to: 10}
  validates :softness, presence: true,
                       numericality: { greater_than_or_equal_to: 1,
                                       less_than_or_equal_to: 10}
end
