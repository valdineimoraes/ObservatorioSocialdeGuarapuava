class PoliticalMandatesController < ApplicationController
  before_action :set_political_mandate, only: %i[show edit update destroy]

  add_breadcrumb I18n.t('breadcrumbs.political_mandate.name'), :political_mandates_path
  add_breadcrumb I18n.t('breadcrumbs.political_mandate.new'),
                 :new_political_mandate_path, only: %i[new create]

  def index
    if params[:search]
      @political_mandates = PoliticalMandate.search(params[:search]).paginate(page: params[:page],
                                                                              per_page: 10).order(first_period: :asc)
    else
      @political_mandates = PoliticalMandate.all.paginate(page: params[:page],
                                                          per_page: 10).order(first_period: :asc)
    end
  end

  def edit
    add_breadcrumb I18n.t('breadcrumbs.political_mandate.edit', name: "##{@political_mandate.description}"),
                   :edit_political_mandate_path
  end

  def show
    add_breadcrumb I18n.t('breadcrumbs.political_mandate.show', name: "##{@political_mandate.description}"),
                   :political_mandate_path
  end

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
      add_breadcrumb I18n.t('breadcrumbs.political_mandate.edit', name: "##{@political_mandate.description}"),
                     :edit_political_mandate_path
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
