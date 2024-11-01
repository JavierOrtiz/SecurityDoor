module Phone
  extend ActiveSupport::Concern

  included do
    before_validation :clean_phone

    validates :phone, presence: true, uniqueness: true
    validate :valid_phone, if: :phone_changed?
  end

  def national_phone
    PhoneLib.parse(phone).national
  end

  def clean_phone
    self.phone = Phonelib.parse(phone, :es).full_e164 if phone
  end

  def valid_phone
    return unless phone

    errors.add(:phone, :invalid) unless Phonelib.valid_for_country?(phone, 'es')
  end
end