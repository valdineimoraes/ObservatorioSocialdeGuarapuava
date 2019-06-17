require 'prawn'

module CouncilmanPdf
  PDF_OPTIONS = {
    # Escolhe o Page size como uma folha A4
    page_size: 'A4',
    # Define o formato do layout como portrait (poderia ser landscape)
    page_layout: :portrait,
    # Define a margem do documento
    margin: [40, 75]
  }.freeze

  def self.councilman(name, nickname, office, political_party, projects)
    Prawn::Document.new(PDF_OPTIONS) do |pdf|
      pdf.image "#{Rails.root}/app/assets/images/os-logo.png", at: [2, 770], width: 100
      # Define a cor do traçado
      pdf.fill_color '666666'
      # Cria um texto com tamanho 30 PDF Points, bold alinha no centro
      pdf.text 'Observatório Social de Guarapuava', size: 16, style: :bold, align: :center
      pdf.text 'Rua XV de Novembro, 7599, Centro', size: 14, style: :bold, align: :center
      pdf.text 'Guarapuava - PR', size: 14, style: :bold, align: :center
      pdf.move_down 30
      pdf.text 'Relatório de Vereador', size: 16, style: :bold, align: :center
      # Move mais 30 PDF points para baixo o cursor
      pdf.move_down 30
      # Escreve o texto
      pdf.text "Vereador: #{name}", size: 14, align: :justify,
                                    inline_format: true
      # Adiciona o nome com 12 PDF points, justify e com o formato inline (Observe que o <b></b> funciona para deixar em negrito)
      pdf.text "Apelido: #{nickname}", size: 12,
                                       align: :justify, inline_format: true
      pdf.text "Cargo: #{office}", size: 12,
                                   align: :justify, inline_format: true
      pdf.text "Partido Político: #{political_party}", size: 12,
                                                       align: :justify, inline_format: true
      pdf.move_down 10

      pdf.text 'Projetos Propostos pelo Vereador', size: 14, style: :bold, align: :center
      pdf.text '_______________________________________________________________'
      projects.each do |project|
        pdf.move_down 2
        pdf.text "Projeto: #{project.name}", size: 12, style: :bold, align: :justify
        pdf.text "Descrição: #{project.description}"
        pdf.text "Tipo de Projeto: #{project.project_kind.kind}"
        pdf.text "Disposto na Sessão: #{project.meeting.date.to_time.strftime('%d/%m/%Y')}"
        pdf.text " #{if project.result.nil?
                       pdf.text 'Resultado da Votação: Sem Votação, ainda não foi votado'
                     else
                       pdf.text "Resultado da Votação #{I18n.t("activerecord.attributes.project.results.#{project.result}")}"
                     end}"
        pdf.text '_______________________________________________________________'
      end

      # Muda de font para Helvetica
      pdf.font 'Helvetica'
      # Inclui em baixo da folha do lado direito a data e o némero da página usando a tag page
      pdf.number_pages "Gerado: #{Time.now.in_time_zone.strftime('%d/%m/%y as %H:%M')} - Página: <page> de <total> ",
                       start_count_at: 1, page_filter: :all, at: [pdf.bounds.right - 170, 7],
                       align: :right, size: 8
      # Gera no nosso PDF e coloca na pasta public
      pdf.render_file('public/pdfs/councilman.pdf')
    end
  end
end
