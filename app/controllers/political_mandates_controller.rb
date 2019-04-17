class PoliticalMandatesController < ApplicationController
  before_action :set_political_mandate, only: %i[show edit update destroy]

  def index
    @political_mandates = PoliticalMandate.all
  end

  def edit; end

  def show; end

  def new
    @political_mandate = PoliticalMandate.new
  end

  def create
    @political_mandate = PoliticalMandate.new(political_mandate_params)
    if @political_mandate.save
      flash[:success] = 'Novo mandato politico criado com sucesso!'
      redirect_to political_mandates_path
    else
      flash[:error] = 'Houve algum problema, reveja os dados inseridos!'
      render :new
    end
  end

  def update
    @political_mandate = PoliticalMandate.find(params[:id])
    if @political_mandate.update(political_mandate_params)
      flash[:success] = 'Mandato politico atualizado com sucesso!'
      redirect_to political_mandates_path
    else
      flash[:error] = 'Não foi possível atualizar, reveja os dados inseridos!'
      render :edit
    end
  end

  def destroy
    @political_mandate.destroy
    flash[:success] = 'Mandato politico destruido com sucesso!'
    redirect_to political_mandates_path
  end

  def councilman
    @councilman = Councilman.find(params[:councilman_id])
  end

  private

  def set_political_mandate
    @political_mandate = PoliticalMandate.find(params[:id])
  end

  def political_mandate_params
    params.require(:political_mandate).permit(:first_period,
                                              :final_period,
                                              :description)
  end
end
