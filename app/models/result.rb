# 結果クラス
class Result < ApplicationRecord
  after_initialize :zero_clear
  # TODO
  belongs_to :campaign
  belongs_to :cuepoint
  private
    # 初期化
    def zero_clear
      # TODO
      self.count_start ||= 0
      self.count_complete ||= 0
    end
end
