module Api
  class CreditsController < Api::ApplicationController
    def show
      total_available = rand(1000)
      render json: {
        total_available: total_available,
        total_used: rand(total_available),
        transactions: [
          { total_paid_in_cents: rand(total_available), currency: 'eur', credits: rand(1000) },
          { total_paid_in_cents: rand(total_available), currency: 'eur', credits: rand(1000) },
          { total_paid_in_cents: rand(total_available), currency: 'eur', credits: rand(1000) }
        ]
      }
    end
  end
end
