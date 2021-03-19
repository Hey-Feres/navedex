# frozen_string_literal: true

#
# API
module Api
  #
  # Version 1
  module V1
    #
    # Navers Endpoints
    class NaversController < ApiController
      before_action :set_naver, only: %i[show update destroy]

      # GET /navers
      def index
        render json: @query, adapter: :json
      end

      # GET /navers/1
      def show
        render json: @naver
      end

      # POST /navers
      def create
        @naver = Naver.new(naver_params)

        if @naver.save
          render json: @naver, status: :created
        else
          render json: @naver.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /navers/1
      def update
        if @naver.update(naver_params)
          render json: @naver
        else
          render json: @naver.errors, status: :unprocessable_entity
        end
      end

      # DELETE /navers/1
      def destroy
        @naver.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_naver
          @naver = Naver.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def naver_params
          params.require(:naver).permit(:name, :birthdate, :admission_date, :job_role, projects_ids: [], remove_projects_ids: [])
        end
    end
  end
end
