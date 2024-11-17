module Api
  class NewsController < Api::ApplicationController
    def index
      total_news_items = 100
      news_items = (1..total_news_items).map do |i|
        {
          id: i,
          title: Faker::Lorem.sentence,
          body: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false),
          published_at: Faker::Time.backward(days: 14, period: :evening)
        }
      end

      page = params[:page].to_i > 0 ? params[:page].to_i : 1
      per_page = params[:per_page].to_i > 0 ? params[:per_page].to_i : 10

      total_pages = (total_news_items.to_f / per_page).ceil

      start_index = (page - 1) * per_page
      paginated_news_items = news_items[start_index, per_page] || []

      render json: {
        current_page: page,
        per_page: per_page,
        total_pages: total_pages,
        total_items: total_news_items,
        news: paginated_news_items
      }
    end

    def show
      render json: {
        id: params[:id],
        title: Faker::Lorem.sentence,
        body: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false),
        published_at: Faker::Time.backward(days: 14, period: :evening)
      }
    end
  end
end
