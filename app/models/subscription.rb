class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  # Обязательно должно быть событие
  validates :event, presence: true

  # Проверки user_name и user_email выполняются,
  # только если user не задан
  # То есть для анонимных пользователей
  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email, presence: true, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/, unless: -> { user.present? }

  # Для конкретного event_id один юзер может подписаться только один раз (если юзер задан)
  validates :user, uniqueness: {scope: :event_id}, if: -> { user.present? }

  # Или один email может использоваться только один раз (если анонимная подписка)
  validates :user_email, uniqueness: {scope: :event_id}, unless: -> { user.present? }

  validate :current_user_event?, if: -> { user.present? }
  validate :email_presence_database?

  # Если есть юзер, выдаем его имя,
  # если нет – дергаем исходный метод
  def user_name
    if user.present?
    user.name
    else
      super
    end
  end

  # Если есть юзер, выдаем его email,
  # если нет – дергаем исходный метод
  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  def current_user_event?
    if event.user == user
      errors.add(:event, I18n.t('subscriptions.subscription.decline_subscription'))
    end
  end

  def email_presence_database?
    if User.exists?(email: user_email.downcase)
      errors.add(:event, I18n.t('subscriptions.subscription.use_of_registered_email'))
    end
  end
end
