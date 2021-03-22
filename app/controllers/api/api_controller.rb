# frozen_string_literal: true

#
# API
module Api
  #
  # Controller that all the other will inherit from
  class ApiController < ApplicationController
    #
    # Modules
    #

    include DeviseTokenAuth::Concerns::SetUserByToken

    #
    # Callbacks
    #

    before_action :authenticate_user!
    before_action :set_query, only: %i[index]

    #
    # Methods
    #

    protected
      #
      # Meta to be used on index actions
      def meta
        { total_pages: count_total_pages, total_records: total_records.to_i }
      end

      #
      # Count totla pages based on page length
      def count_total_pages
        (total_records / length).ceil
      end

      #
      # Count all the records of model that was requested
      def total_records
        scope.count.to_f
      end

      #
      # Return the length received as param or 20 if page's param is nil
      def length
        params[:length]&.to_f || 20
      end

      #
      # Return the page received as param or 1 if page's param is nil
      def page
        params[:page] || 1
      end

      #
      # Define the model name trought controller name
      def model_from_controller(controller = '')
        return if controller&.to_s.blank?

        controller = controller.to_s
        controller.split('::').each do |str|
          if str.include?('Controller')
            controller = str
            break
          end
        end
        controller.remove('Controller').singularize.constantize
      end

      #
      # Scope to be passed to set_query method
      def scope
        model_from_controller(self.class).all
      end

      #
      # Filter the received params
      def filter_query_params
        if scope.column_names.exclude?(params[:sort_by]&.to_s) || %w[asc desc].exclude?(params[:order_by]&.to_s)
          params[:sort_by] = 'created_at'
          params[:order_by] = 'asc'
        end
      end

      #
      # Check if the search could be done
      def should_search?
        params[:search_by].present? && params[:search_for].present?
      end

      #
      # Set the query for index actions
      def set_query
        filter_query_params
        @query = scope
        @query = @query.search(search_by: params[:search_by], search_for: params[:search_for]) if should_search?
        @query = @query.order(params[:sort_by].to_sym => params[:order_by].to_sym)
        @query = @query.paginate(page: page, length: length)
      end
  end
end