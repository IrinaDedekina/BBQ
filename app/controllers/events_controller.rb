class EventsController < ApplicationController
  # Встроенный в девайз фильтр - посылает незалогиненного пользователя
  before_action :authenticate_user!, except: [:show, :index]

  before_action :set_event, except: [:index, :new, :create]

  before_action :password_guard!, only: [:show]

  # Задаем объект @event от текущего юзера для других действий
  after_action :verify_authorized, only: [:edit, :update, :destroy, :show]

  after_action :verify_policy_scoped, only: :index

  def index
    @events = policy_scope(Event)
  end

  def show
    authorize @event
    @new_comment = @event.comments.build(params[:comment])
    @new_subscription = @event.subscriptions.build(params[:subscription])
    # Болванка модели для формы добавления фотографии
    @new_photo = @event.photos.build(params[:photo])
  end

  def new
    @event = current_user.events.build

    authorize @event
  end

  def edit
    authorize @event
  end

  def create
    @event = current_user.events.build(event_params)

    authorize @event

    if @event.save
      # Используем сообщение из файла локалей ru.yml
      # controllers -> events -> created
      redirect_to @event, notice: I18n.t('controllers.events.created')
    else
      render :new
    end
  end

  def update
    authorize @event

    if @event.update(event_params)
      redirect_to @event, notice: I18n.t('controllers.events.updated')
    else
      render :edit
    end
  end

  def destroy
    authorize @event

    @event.destroy
    redirect_to user_path(user), notice: I18n.t('controllers.events.destroyed')
  end

  private

  def password_guard!
    return true if @event.pincode.blank?
    return true if signed_in? && current_user == @event.user

    if params[:pincode].present? && @event.pincode_valid?(params[:pincode])
      cookies.permanent["events_#{@event.id}_pincode"] = params[:pincode]
    end

    pincode = cookies.permanent["events_#{@event.id}_pincode"]
    unless @event.pincode_valid?(pincode)
      if params[:pincode].present?
        flash.now[:alert] = I18n.t('controllers.events.wrong_pincode')
      end
      render 'password_form'
    end
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event)
      .permit(:title, :address, :datetime, :description, :pincode)
  end
end
