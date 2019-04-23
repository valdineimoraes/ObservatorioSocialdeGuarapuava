class CouncilmenController < ApplicationController
  before_action :set_councilman, only: %i[show edit update destroy]

  add_breadcrumb I18n.t('breadcrumbs.councilman.name'), :councilmen_path
  add_breadcrumb I18n.t('breadcrumbs.councilman.new'),
                 :new_councilman_path, only: %i[new create]

  def index
    if params[:search]
      @councilmen = Councilman.search(params[:search]).paginate(page: params[:page],
                                                                per_page: 10).order(name: :asc)
    else
      @councilmen = Councilman.all.paginate(page: params[:page],
                                            per_page: 10).order(name: :asc)
    end
  end

  def show
    add_breadcrumb I18n.t('breadcrumbs.councilman.show',
                          name: "##{@councilman.id}"), :councilman_path
  end

  def new
    @councilman = Councilman.new
  end

  def edit
    add_breadcrumb I18n.t('breadcrumbs.councilman.edit', name: "##{@councilman.id}"),
                   :edit_councilman_path
  end

  def create
    @councilman = Councilman.new(councilman_params)
    if @councilman.save
      flash[:success] = 'Novo vereador adicionado!'
      redirect_to @councilman
    else
      flash[:error] = 'Houve algum problema, reveja os dados inseridos!'
      render :new
    end
  end

  def update
    if @councilman.update(councilman_params)
      flash[:success] = 'Vereador atualizado com sucesso!'
      redirect_to councilmen_path
    else
      add_breadcrumb I18n.t('breadcrumbs.councilman.edit', name: "##{@councilman.id}"),
                     :edit_councilman_path
      flash[:error] = 'Houve algum problema, reveja os dados inseridos !'
      render :edit
    end
  end

  def destroy
    @councilman.destroy
    flash[:success] = 'Vereador destruido com sucesso!'
    redirect_to councilmen_path
  end

  def political_mandates
    @political_mandate = PoliticalMandate.find(params[:political_mandates_id])
  end

  def projects
    @councilman = Councilman.find(params[:councilman_id])
  end

  private

  def set_councilman
    @councilman = Councilman.find(params[:id])
  end

  def councilman_params
    params.require(:councilman).permit(:name,
                                       :nickname,
                                       :office,
                                       :political_party,
                                       :political_mandate_id,
                                       :avatar)
  end
end
