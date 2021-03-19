# frozen_string_literal: true

#
# API
module Api
  #
  # Version 1
  module V1
    #
    # Projects Endpoints
    class ProjectsController < ApiController
      before_action :set_project, only: [:show, :update, :destroy]

      # GET /projects
      def index
        render json: @query, include: %i[navers], meta: meta
      end

      # GET /projects/1
      def show
        render json: @project, include: %i[navers]
      end

      # POST /projects
      def create
        @project = Project.new(project_params)

        if @project.save
          render json: @project, include: %i[navers], status: :created
        else
          render json: @project.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /projects/1
      def update
        if @project.update(project_params)
          render json: @project, include: %i[navers]
        else
          render json: @project.errors, status: :unprocessable_entity
        end
      end

      # DELETE /projects/1
      def destroy
        @project.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_project
          @project = Project.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def project_params
          params.require(:project).permit(:name, navers_ids: [])
        end
    end
  end
end
