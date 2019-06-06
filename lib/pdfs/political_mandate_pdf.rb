require 'prawn'

module PoliticalMandatePdf
  PDF_OPTIONS = {
    # Escolhe o Page size como uma folha A4
    page_size: 'A4',
    # Define o formato do layout como portrait (poderia ser landscape)
    page_layout: :portrait,
    # Define a margem do documento
    margin: [40, 75]
  }.freeze

  def self.political_mandate(description, first_period, final_period, qtde_councilman, councilmen)
    Prawn::Document.new(PDF_OPTIONS) do |pdf|
      pdf.image "#{Rails.root}/app/assets/images/os-logo.png", at: [2, 770], width: 100
      # Define a cor do traçado
      pdf.fill_color '666666'
      # Cria um texto com tamanho 30 PDF Points, bold alinha no centro
      pdf.text 'Observatório Social de Guarapuava', size: 16, style: :bold, align: :center
      pdf.text 'Rua XV de Novembro, 7599, Centro', size: 14, style: :bold, align: :center
      pdf.text 'Guarapuava - PR', size: 14, style: :bold, align: :center
      pdf.move_down 30
      pdf.text 'Relatório de Mandato Político', size: 16, style: :bold, align: :center
      # Move mais 30 PDF points para baixo o cursor
      pdf.move_down 30
      # Escreve o texto
      pdf.text "Mandato: #{description}", size: 14, align: :justify,
                                          inline_format: true
      # Move mais 30 PDF points para baixo o cursor
      pdf.move_down 10
      # Adiciona o nome com 12 PDF points, justify e com o formato inline (Observe que o <b></b> funciona para deixar em negrito)
      pdf.text "Periodo Inicial: #{first_period}", size: 12,
                                                   align: :justify, inline_format: true
      pdf.move_down 5
      pdf.text "Periodo Final: #{final_period}", size: 12,
                                                 align: :justify, inline_format: true
      pdf.move_down 5
      pdf.text "Qtde de Vereadores: #{qtde_councilman}", size: 12,
                                                    align: :justify, inline_format: true
      pdf.move_down 5
      councilmen.each do |councilman|
        pdf.text "Nome: #{councilman.name} "
        pdf.move_down 2
      end
      pdf.font 'Helvetica'
      # Inclui em baixo da folha do lado direito a data e o némero da página usando a tag page
      pdf.number_pages "Gerado: #{Time.now.strftime('%d/%m/%y as %H:%M')} - Página ", start_count_at: 0,
                                                                                      page_filter: :all, at: [pdf.bounds.right - 140, 7], align: :right, size: 8
      # Gera no nosso PDF e coloca na pasta public
      pdf.render_file('public/political_mandate.pdf')
    end
  end
end
