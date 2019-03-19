# frozen_string_literal: true

class PoliticalMandatesController < ApplicationController
  before_action :set_political_mandate, only: %i[show edit update destroy]

  def index
    @political_mandates = PoliticalMandate.all
  end

  def def(_new)
    @political_mandate = PoliticalMandate.new
  end

  def edit; end

  def show; end

  def new
    @political_mandate = PoliticalMandate.new
  end

  def create
    @political_mandate = PoliticalMandate.new(political_mandate_params)
    if @political_mandate.save
      success_create_message
      redirect_to root_path
    else
      error_message
      render :new
    end
  end

  def update
    @political_mandate = PoliticalMandate.find(params[:id])
    if @political_mandate.update(political_mandate_params)
      success_update_message
      redirect_to root_path
    else
      error_message
      render :edit
    end
  end

  def destroy
    @political_mandate.destroy
    success_destroy_message
    redirect_to root_path
  end

  private

  def set_political_mandate
    @political_mandate = PoliticalMandate.find(params[:id])
  end

  def political_mandate_params
    params.require(:political_mandate).permit(:first_period, :final_period, :description)
  end
end
