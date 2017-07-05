# キャンペーン用コントローラ
class CampaignsController < ApplicationController
  # 一覧表示
  def index
    unless params[:cuepoint_id]
    @campaigns = Campaign.all
      # TODO
    else
      # 下記はVAST URL呼び出しを想定
      # TODO
      @cuepoint = Cuepoint.find(params[:cuepoint_id])
      @campaigns = Campaign.current_avaliable(@cuepoint)
      response.headers['Access-Control-Allow-Origin'] = request.headers['Origin'] || '*'
      response.headers['Access-Control-Allow-Methods'] = 'GET'
      headers['Access-Control-Request-Method'] = '*'
      headers['Access-Control-Allow-Credentials'] = 'true'
      headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type'
    end
  end

  # 新規
  def new
    # TODO
    @campaign = Campaign.new
    @cuepoint = Cuepoint.all
  end

  # 作成
  def create
    # TODO
    @campaign = Campaign.new (campaign_params)
    
    if @campaign.save
      flash[:success] = "キャンペーンを登録しました。"
      redirect_to campaigns_url
    else
      @cuepoints = Cuepoint.all
      flash.now[:danger] = "キャンペーンの登録に失敗しました。"
      render :new
    end
  end

  # 編集
  def edit
    # TODO
    @campaign = Campaign.find(params[:id])
    @cuepoints = Cuepoint.all
  end

  # 更新
  def update
    # TODO
    @campaign = Campaign.find(params[:id])
    if @campaign.update(campaign_params) || @cuepoint.update(cuepoint_params)
      flash.now[:success] = 'キャンペーンを登録しました。'
      redirect_to root_path
    else
      flash.now[:danger] = 'キャンペーンの登録に失敗しました。'
      render :edit
    end
  end

  # 削除
  def destroy
    # TODO
    @campaign = Campaign.find(params[:id])
    @campaign.destroy
    flash[:success] = 'キャンペーンを削除しました。'
    redirect_to root_path
  end

  private
    # キャンペーン用パラメータ
    def campaign_params
      # TODO
      params.require(:campaign).permit(:name, :start_at, :end_at, :limit_start, :movie_url, cuepoint_ids: [] )
    end
end


