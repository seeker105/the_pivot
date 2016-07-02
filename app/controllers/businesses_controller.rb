class BusinessesController < ApplicationController

  def index
    @businesses = Business.all
  end

  def show
    #code
  end
end
