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
    res = clnt.head(params[:url])
    @resource.last_updated = res.header['Last-Modified'][0]
    @resource.hash_content = 0
    if @resource.save
      #head :created
      render json: @resource, status: :created #, location: @resource
    else
      #head :bad_request
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
