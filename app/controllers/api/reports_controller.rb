module Api
  class ReportsController < Api::ApplicationController
    skip_before_action :authenticate
    def index
      @reports = Report.where(analyzed: true).order(created_at: :desc)
      render json: @reports.as_json(only: %w[content is_scam recommendations reasons url domain entity subject])
    end

    def show
      message = Report.find_by(id: params[:id])

      if message.nil?
        render json: { error: "not_found" }, status: :not_found
      elsif message.analyzed
        render json: {
          is_scam: message.is_scam,
          recommendations: message.recommendations,
          reasons: message.reasons,
          status: "completed"
        }, status: :ok
      else
        render json: { status: "in_progress" }, status: :ok
      end
    end
  end
end
