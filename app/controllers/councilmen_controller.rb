# frozen_string_literal: true

class CouncilmenController < ApplicationController
  before_action :set_councilman, only: %i[show edit update destroy]

  def index
    if params[:search]
      @councilmen = Councilman.search(params[:search]).paginate(page: params[:page], per_page: 5).order(name: :asc)
    else
      @councilmen = Councilman.all.paginate(page: params[:page], per_page: 5).order(name: :asc)
    end
  end

  def show; end

  def new
    @councilman = Councilman.new
  end

  def edit; end

  def create
    @councilman = Councilman.new(councilman_params)

    respond_to do |format|
      if @councilman.save
        flash[:success] = 'Novo vereador adicionado!'
        format.html { redirect_to @councilman }
        format.json { render :show, status: :created, location: @councilman }
      else
        flash[:error] = 'Houve algum problema, reveja os dados inseridos!'
        format.html { render :new }
        format.json { render json: @councilman.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @councilman.update(councilman_params)
        format.html { redirect_to @councilman, notice: 'Vereador atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @councilman }
      else
        flash[:error] = 'Houve algum problema, reveja os dados inseridos !'

        format.html { render :edit }
        format.json { render json: @councilman.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @councilman.destroy
    respond_to do |format|
      format.html { redirect_to councilmen_url, notice: 'Vereador removido com sucesso.' }
      format.json { head :no_content }
    end
  end

  def projects
    @councilman = Councilman.find(params[:councilman_id])
  end

  private

  def set_councilman
    @councilman = Councilman.find(params[:id])
  end

  def councilman_params
    params.require(:councilman).permit(:name, :nickname, :political_party, :political_position, :avatar)
  end
end
