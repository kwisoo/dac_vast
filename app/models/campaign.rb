# キャンペーンクラス
class Campaign < ApplicationRecord
  # TODO
  has_and_belongs_to_many :cuepoints
  has_many :results, dependent: :destroy
  validates :name, presence: true, uniqueness: true, length: { maximum: 20, minimum: 5  }
  validates :start_at, presence: true 
  validates :end_at, presence: true
  validate :start_and_end 
  validates :limit_start, presence: true, numericality: { only_integer: true }, length: { maximum: 10000, minimum: 0 }
  validates :movie_url, presence: true, length: { maximum: 100, minimum: 5 }
  
  def start_and_end
    if start_at.present? && start_at > end_at
      errors.add(:start_at, "start_at must be smaller than end_at")
    end
  end


  # 有効なキャンペーン一覧を返す
  #  - 対象のCue Pointと紐付いている。
  #  - キャンペーンが開始していて、終了する前。
  #  - Resultのスタート数(count_start)がキャンペーンの制限(limit_start)以内。
  # @param [Cuepoint, #read] cuepoint キャンペーンの対象となっている Cue Point
  # @return [Array] 該当キャンペーンの配列
  def self.current_avaliable(cuepoint)
    # TODO
    campaigns = cuepoint.campaigns.
      where("start_at <= '#{Time.now}' AND end_at >= '#{Time.now}'").to_a
    campaigns.delete_if do |campaign|
      result = Result.where(campaign: campaign, cuepoint: @cuepoint).first
      !result.blank? && result.count_start >= campaign.limit_start
    end
  end
end
