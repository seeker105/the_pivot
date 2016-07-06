module Api
  module V1
    class BusinessesController < ApiController
      def index
        respond_with Business.all
      end
      def update
        byebug
      end
    end
  end
end
