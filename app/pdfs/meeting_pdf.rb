class MeetingPdf < Prawn::Document

  def initialize(meeting)
    super(top_margin: 70)
    @meeting = meeting
    meeting_date
    #meetings_items
  end

  def meeting_date
    text "Sessão do Dia: #{@meeting.date}", size:18, style: :bold, align: :center
  end

  def meetings_items
    move_down 20
    table meetings_rows do
      row(0).font_style = :bold
      columns(1..3).align = :right
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
    end
  end

  def meetings_rows
    [["Data da Sessão", "Inicio da Sessão", "Fim da Sessão", "Notas"]] +
        @meeting.meetings_items.map do |item|
          [item.date, item.start_session, item.end_session, item.note]
        end
  end
end