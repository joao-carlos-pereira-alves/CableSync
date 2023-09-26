class ChatChannel < ApplicationCable::Channel
  def subscribed
    chat_id = params[:chat_id]
    stream_from "chat_#{params[:chat_id]}"
  end

  def unsubscribed
    chat_id = params[:chat_id]
    stop_stream_from "chat_#{params[:chat_id]}"
  end

  def receive(data)
    chat_id      = params[:chat_id]
    # user_id      = data.dig('user_id')
    message_data = {
      type: 'message', # Tipo da mensagem
      content: data.dig('body_message'), # Conteúdo da mensagem
      username: data.dig('username'),
      created_at: DateTime.now.strftime('%d/%m/%Y às %H:%M')
    }

    begin
      ActionCable.server.broadcast("chat_#{chat_id}", message_data)

      # TODO: Se for necessário salvar as mensagens, utilize o método abaixo e envie uma mensagem novamente para o canal após o evento after_create_commit.
      # Message.create!(chat_id: chat_id, user_id: user_id, body: body_message)
    rescue
      ActionCable.server.broadcast("chat_#{chat_id}", 'Bate papo temporariamente indisponível.')
    end
  end
end
