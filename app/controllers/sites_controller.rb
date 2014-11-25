class SitesController < ApplicationController

  # GET /sites #ALL
  def index
    @sites = Site.where(user_id: current_user)
    @site = Site.new
  end

  # POST /sites
  def create
    @site = current_user.sites.build
    url = params[:site][:url]
    url = "http://#{url}" unless url[0..3]==:http
    @site.url=url
    clnt = HTTPClient.new
    @site.last_updated = clnt.head(url).header['Last-Modified'][0]
    doc = Nokogiri::HTML(clnt.get_content(url))
    ## TODO: validate
    @site.hash_content = Digest::MD5.hexdigest(doc.xpath("//body").first)
    @site.save!
    redirect_to root_path
  end

  # DELETE /sites/1
  def destroy
    Site.find(params[:id]).destroy
    redirect_to root_path
  end

  private

  def site_params
    params.require(:site).permit(:url)
  end
end
