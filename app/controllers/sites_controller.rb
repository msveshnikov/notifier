class SitesController < ApplicationController

  # GET /sites #ALL
  def index
    @sites = Site.all
    @site = Site.new
    #render json: @sites
  end

  # GET /sites/1
  def show
    @site = Site.find_by(user_id: params[:user_id])
    render json: @site
  end

  # POST /sites
  def create
    @site = Site.new(site_params) #.except(:user_id))
    clnt = HTTPClient.new
    url=params[:site][:url]
    url="http://#{url}" unless url[0..3]==:http
    @site.url=url
    @site.last_updated = clnt.head(url).header['Last-Modified'][0]
    doc = Nokogiri::HTML(clnt.get_content(url))
    @site.hash_content = Digest::MD5.hexdigest(doc.xpath("//body").first)

    if @site.save
      #render json: @site, status: :created
      redirect_to root_path
    else
      render json: @site.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sites/1
  def destroy
    @site = Site.find(params[:id])
    @site.destroy

    redirect_to root_path
#    head :no_content
  end

  private

  def site_params
    params.require(:site).permit(:url, :user_id, :id)
  end
end
