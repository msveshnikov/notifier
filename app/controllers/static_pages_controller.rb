class StaticPagesController < ApplicationController
  def home
  end

  def about
    flash.now[:alert] = "Your book was not found"
  end
end
