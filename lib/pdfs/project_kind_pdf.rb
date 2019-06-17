require 'prawn'

module ProjectKindPdf
  PDF_OPTIONS = {
    # Escolhe o Page size como uma folha A4
    page_size: 'A4',
    # Define o formato do layout como portrait (poderia ser landscape)
    page_layout: :portrait,
    # Define a margem do documento
    margin: [40, 75]
  }.freeze

  def self.project_kind(kind, description, number_projects, projects)
    Prawn::Document.new(PDF_OPTIONS) do |pdf|
      pdf.image "#{Rails.root}/app/assets/images/os-logo.png", at: [2, 770], width: 100
      # Define a cor do traçado
      pdf.fill_color '666666'
      # Cria um texto com tamanho 30 PDF Points, bold alinha no centro
      pdf.text 'Observatório Social de Guarapuava', size: 16, style: :bold, align: :center
      pdf.text 'Rua XV de Novembro, 7599, Centro', size: 14, style: :bold, align: :center
      pdf.text 'Guarapuava - PR', size: 14, style: :bold, align: :center

      pdf.move_down 30
      pdf.text 'Relatório de Tipo de Projeto', size: 16, style: :bold, align: :center
      # Move mais 30 PDF points para baixo o cursor
      pdf.move_down 30
      # Escreve o texto
      pdf.text "Tipo de Projeto: #{kind}", size: 14, align: :justify,
                                           inline_format: true
      # Move mais 30 PDF points para baixo o cursor
      pdf.move_down 10
      # Adiciona o nome com 12 PDF points, justify e com o formato inline (Observe que o <b></b> funciona para deixar em negrito)
      pdf.text "Descrição: #{description}", size: 12,
                                            align: :justify, inline_format: true
      pdf.move_down 5
      pdf.text "Qtde de Projetos cadastrado: #{number_projects}", size: 12,
                                                                  align: :justify, inline_format: true

      # Projetos cadastrados no tipo de ṕrojeto
      pdf.move_down 10
      pdf.text 'Lista de Projetos cadastrados', size: 12, style: :bold,
                                                align: :center, inline_format: true
      pdf.text '_______________________________________________________________'

      projects.each do |project|
        pdf.text "Projeto: #{project.name}", size: 12, style: :bold, align: :justify
        pdf.text "Descrição: #{project.description}"
        pdf.text "Proposto pelo(a) Vereador(a): #{project.councilman.name} "
        pdf.text " #{if project.result.nil?
                       pdf.text 'Resultado da Votação: Sem Resultado pois ainda não foi votado.'
                     else
                       pdf.text "Resultado da Votação: #{I18n.t("activerecord.attributes.project.results.#{project.result}")}"
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
      pdf.render_file('public/pdfs/project_kind.pdf')
    end
  end
end
