class Report::AnalyzeJob < ApplicationJob
  queue_as :default

  SIMILARITY_THRESHOLD = 0.3  # Ajusta según la precisión que desees

  def perform(message_id)
    message = Report.find(message_id)

    # similar_message = Report
    #                     .where(analyzed: true)
    #                     .where("similarity(keywords_text, ?) > ?", message.keywords_text, SIMILARITY_THRESHOLD)
    #                     .order(Arel.sql("similarity(keywords_text, '#{message.keywords_text}') DESC"))
    #                     .first

    # if similar_message
    #   message.update(
    #     is_scam: similar_message.is_scam,
    #     recommendations: similar_message.recommendations,
    #     reasons: similar_message.reasons,
    #     url: similar_message.url,
    #     domain: similar_message.domain,
    #     entity: similar_message.entity,
    #     keywords: similar_message.keywords
    #   )
    # else
      response = HTTParty.post(
        'https://jortizdev.app.n8n.cloud/webhook/api/analyze',
        body: { content: message.content }.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )

      if response.success?
        data = response.parsed_response
        message.update(
          is_scam: data["is_scam"],
          analyzed: true,
          recommendations: data["recommendations"],
          reasons: data["reasons"],
          url: data["url"],
          domain: data["domain"],
          entity: data["entity"],
          subject: data["subject"],
          keywords: data["keywords"]
        )
      else
        Rails.logger.error("Failed to analyze message with ID #{message.id}")
      end
    # end
  end
end