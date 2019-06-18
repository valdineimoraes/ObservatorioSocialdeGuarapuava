require 'prawn'

module ProjectPdf
  PDF_OPTIONS = {
    # Escolhe o Page size como uma folha A4
    page_size: 'A4',
    # Define o formato do layout como portrait (poderia ser landscape)
    page_layout: :portrait,
    # Define a margem do documento
    margin: [40, 75]
  }.freeze

  def self.project(name, description, project_kind, councilman, meeting, result, votes)
    Prawn::Document.new(PDF_OPTIONS) do |pdf|
      pdf.image "#{Rails.root}/app/assets/images/os-logo.png", at: [2, 770], width: 100
      # Define a cor do traçado
      pdf.fill_color '666666'
      # Cria um texto com tamanho 30 PDF Points, bold alinha no centro
      pdf.text 'Observatório Social de Guarapuava', size: 16, style: :bold, align: :center
      pdf.text 'Rua XV de Novembro, 7599, Centro', size: 14, style: :bold, align: :center
      pdf.text 'Guarapuava - PR', size: 14, style: :bold, align: :center
      pdf.move_down 30
      pdf.text 'Relatório de Projeto', size: 16, style: :bold, align: :center
      # Move mais 30 PDF points para baixo o cursor
      pdf.move_down 30
      # Escreve o texto
      pdf.text "Projeto: #{name}", size: 14, align: :justify,
                                   inline_format: true

      pdf.move_down 5
      pdf.text "Tipo do Projeto: #{project_kind}", size: 12,
                                                   align: :justify, inline_format: true

      pdf.move_down 10
      # Adiciona o nome com 12 PDF points, justify e com o formato inline (Observe que o <b></b> funciona para deixar em negrito)
      pdf.text "Descrição do Projeto: #{description}", size: 12,
                                                       align: :justify, inline_format: true

      pdf.move_down 5
      pdf.text "Vereador que Propos: #{councilman}", size: 12,
                                                     align: :justify, inline_format: true
      pdf.move_down 5
      pdf.text "Disposto na Sessão do dia: #{meeting}", size: 12,
                                                        align: :justify, inline_format: true

      pdf.move_down 10
      pdf.text 'Votos dos Vereadores no Projeto', size: 12, style: :bold,
                                                  align: :center, inline_format: true

      pdf.text '_______________________________________________________________'
      votes.each do |v|
        pdf.text "Vereador(a): #{v.councilman.name} ----- Voto: #{I18n.t("enums.votes.vote.#{v.vote}")}"
        pdf.move_down 2
      end
      pdf.text '_______________________________________________________________'

      pdf.move_down 5
      pdf.text " #{if result.nil?
                     pdf.text 'Resultado da Votação: Sem Votação, ainda não foi votado',
                              size: 12, style: :bold, align: :justify, inline_format: true
                   else
                     pdf.text "Resultado da Votação: #{I18n.t("activerecord.attributes.project.results.#{result}")}",
                              size: 12, style: :bold, align: :justify, inline_format: true
                   end}"

      # Muda de font para Helvetica
      pdf.font 'Helvetica'
      # Inclui em baixo da folha do lado direito a data e o némero da página usando a tag page
      pdf.number_pages "Gerado: #{Time.now.in_time_zone.strftime('%d/%m/%y as %H:%M')} - Página: <page> de <total> ",
                       start_count_at: 1, page_filter: :all, at: [pdf.bounds.right - 170, 7],
                       align: :right, size: 8
      # Gera no nosso PDF e coloca na pasta public
      pdf.render_file('public/pdfs/project.pdf')
    end
  end
end
