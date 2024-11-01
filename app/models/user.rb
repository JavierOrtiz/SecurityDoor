class User < ApplicationRecord
  include Phone

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  after_create :send_welcome_email
  has_rich_text :bio

  validates_presence_of :full_name
  # validate :email_must_be_invited
  # validate :must_be_of_age

  enum status: [:created, :verified, :admin, :beta]

  private

  def email_must_be_invited
    unless Invite.accepted.exists?(email: email)
      errors.add(:email, "debe tener una invitación para poder registrarse.")
    end
  end

  def must_be_of_age
    if birth_date.present?
      if birth_date > 16.years.ago
        errors.add(:birth_date, "debes tener al menos 16 años")
      end
    else
      errors.add(:birth_date, "debe ser rellenado")
    end
  end

  def check_invitations
    invite = Invite.find_by email: email
    invite.registered! if invite
  end

  def send_welcome_email
    WelcomeMailer.welcome(self).deliver
  end

  def is_beta?
    add_badge(2) if ENV['BETA_MODE']
  end
end
