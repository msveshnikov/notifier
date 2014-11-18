class ResourcesController < ApplicationController

  # GET /resources #ALL
  def index
    @resources = Resource.all
    render json: @resources
  end

  # GET /resources/1
  def show
    @resource = Resource.find_by(user_id: params[:user_id])
    render json: @resource
  end

  # POST /resources
  def create
    @resource = Resource.new(resource_params) #.except(:user_id))
    clnt = HTTPClient.new
    @resource.last_updated = clnt.head(params[:url]).header['Last-Modified'][0]
    doc = Nokogiri::HTML(clnt.get_content(params[:url]))
    @resource.hash_content = Digest::MD5.hexdigest(doc.xpath("//body").first)

    if @resource.save
      render json: @resource, status: :created
    else
      render json: @resource.errors, status: :unprocessable_entity
    end
  end

  # DELETE /resources/1
  def destroy
    @resource = Resource.find(params[:id])
    @resource.destroy

    head :no_content
  end

  private

  def resource_params
    params.permit(:url, :user_id)
  end
end
