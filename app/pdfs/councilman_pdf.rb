class CouncilmanPdf < Prawn::Document

  def initialize(councilmen)
    super()
    @councilmen = Councilman.order(name: :asc).all
    text "Relatório de todos os Vereadores", size:18, style: :bold, align: :center
    #councilmen_id
  end

  def councilmen_id
    table councilmen_all do
      row(0).font_style = :bold
      columns(1..3).align = :right
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
    end
  end

  def councilmen_all
    [["Nome", "Apelido", "Partido", "Cargo" ]] +
        @councilmen.map do |councilman|
          [councilman.name, councilman.nickname,
           councilman.political_party, councilman.office]
        end
  end

  # ver como fazer para pegar quantos projetos o mesmo apresentou
  #

end