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
    @site.url = url
    begin
      @site.hash_content = hash_from_url(url)
      #@site.last_updated = clnt.head(url).header['Last-Modified'][0]
      @site.save!
    rescue
      flash[:error] = "Wrong URL!"
    end
    #File.write('c:\site.txt', text)
    redirect_to root_path
  end

  # DELETE /sites/1
  def destroy
    Site.find(params[:id]).destroy
    redirect_to root_path
  end

  def self.hash_from_url(url)
    clnt = HTTPClient.new
    doc = Nokogiri::HTML(clnt.get_content(url))
    doc.css('script, link').each { |node| node.remove }
    text = doc.css('body').text
    Digest::MD5.hexdigest(text)
  end
end
