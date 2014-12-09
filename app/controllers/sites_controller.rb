class SitesController < ApplicationController
  before_action :set_site, only: [:show, :destroy, :update]

  # GET /sites #ALL
  def index
    @sites = Site.where(user_id: current_user ? current_user : User.find(1))
    @categories = Category.select { |cat| cat.sites.where(user_id: current_user ? current_user : User.find(1)).size > 0 }
    @site = Site.new
  end

  # POST /sites
  def create
    @site = current_user.sites.build
    url = params[:site][:url]
    url = "http://#{url}" unless url[0..3]=="http"
    @site.url = url
    begin
      @site.calc_hash
    rescue
      flash[:error] = "Wrong URL!"
    end
    redirect_to root_path
  end

  # DELETE /sites/1
  def destroy
    @site.destroy if current_user
    redirect_to root_path
  end

  def update
    @site.update_attributes(site_params)  if current_user
    redirect_to root_path
  end

  def show
    @site.update_attributes(site_params) if current_user
    render :show, layout: false
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_site
    @site = Site.find(params[:id])
  end

  def site_params
    params.permit(:category_id, :was_changed)
  end
end
