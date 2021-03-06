# レポート関連コントローラ
class ResultsController < ApplicationController
  # 結果一覧表示
  def index
    # TODO
    @results = Result.all
  end

  # 結果追加
  def record
    # TODO
    @campaign = Campaign.find(params[:campaign])
    @cuepoint = Cuepoint.find(params[:cuepoint])
    
    @result = Result.find_or_initialize_by(campaign: @campaign, cuepoint: @cuepoint)
    
    if params[:event] == "start"
      @result.count_start +=1
      
    elsif params[:event] == "complete"
      @result.count_complete +=1
    
    end
    
  @result.save
  
    send_data(Base64.decode64('R0lGODlhAQABAPAAAAAAAAAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw=='),
      type: 'image/gif', disposition: 'inline')
  end
end
