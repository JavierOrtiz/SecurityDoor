module Api
  class MessagesController < Api::ApplicationController
    skip_before_action :authenticate
    def create
      if params[:message].present?
        message = Report.create(content: params[:message])

        Report::AnalyzeJob.perform_later(message.id)

        render json: { id: message.id, status: "in_progress" }, status: :ok
      else
        render json: { error: "request_error" }, status: :bad_request
      end
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
