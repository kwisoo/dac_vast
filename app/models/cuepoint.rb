# キューポイントクラス
class Cuepoint < ApplicationRecord
  # TODO
  has_and_belongs_to_many :campaigns
  has_many :results, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { maximum: 20, minimum: 5  }

end
