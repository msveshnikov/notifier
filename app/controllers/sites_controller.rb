class SitesController < ApplicationController

  # GET /sites #ALL
  def index
    @sites = Site.where(user_id: current_user)
    @categories=Category.select { |cat| cat.sites.where(user_id: current_user).size > 0 }
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
    Site.find(params[:id]).destroy
    redirect_to root_path
  end

  def update
    @site=Site.find(params[:id]).update_attributes(site_params)
    redirect_to root_path
  end

  private

  def site_params
    params.permit(:category_id, :was_changed)
  end
end
