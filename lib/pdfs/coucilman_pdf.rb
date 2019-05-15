require 'prawn'

module CouncilmanPdf
  PDF_OPTIONS = {
      # Escolhe o Page size como uma folha A4
      :page_size   => "A4",
      # Define o formato do layout como portrait (poderia ser landscape)
      :page_layout => :portrait,
      # Define a margem do documento
      :margin      => [40, 75]
  }

  def self.councilman name, nickname, office, political_party
    Prawn::Document.new(PDF_OPTIONS) do |pdf|
      pdf.image "#{Rails.root}/app/assets/images/os-logo.png", :at => [2, 770], :width => 100
      # Define a cor do traçado
      pdf.fill_color "666666"
      # Cria um texto com tamanho 30 PDF Points, bold alinha no centro
      pdf.text "Observatório Social de Guarapuava", :size => 16, :style => :bold, :align => :center
      pdf.text "Rua XV de Novembro, 7599, Centro", :size => 14, :style => :bold, :align => :center
      pdf.text "Guarapuava - PR", :size => 14, :style => :bold, :align => :center
      pdf.move_down 30
      pdf.text "Relatório de Vereador", :size => 16, :style => :bold, :align => :center
      # Move mais 30 PDF points para baixo o cursor
      pdf.move_down 30
      # Escreve o texto 
      pdf.text "Vereador: #{name}", :size => 14, :align => :justify,
               :inline_format => true
      # Move mais 30 PDF points para baixo o cursor
      pdf.move_down 10
      # Adiciona o nome com 12 PDF points, justify e com o formato inline (Observe que o <b></b> funciona para deixar em negrito)
      pdf.text "Apelido: #{nickname}", :size => 12,
               :align => :justify, :inline_format => true
      pdf.text "Nome: #{office}", :size => 12,
               :align => :justify, :inline_format => true
      pdf.text "Apelido: #{political_party}", :size => 12,
               :align => :justify, :inline_format => true
      # Muda de font para Helvetica
      pdf.font "Helvetica"
      # Inclui em baixo da folha do lado direito a data e o némero da página usando a tag page
      pdf.number_pages "Gerado: #{(Time.now).strftime("%d/%m/%y as %H:%M")} - Página ", :start_count_at => 0,
                       :page_filter => :all, :at => [pdf.bounds.right - 140, 7], :align => :right, :size => 8
      # Gera no nosso PDF e coloca na pasta public 
      pdf.render_file('public/councilman.pdf')
    end
  end

end