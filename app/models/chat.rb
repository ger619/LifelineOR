class Chat < ApplicationRecord
  belongs_to :user
  attr_accessor :message

  def message=(message)
    self.history = { 'prompt' => message, 'history' => [] } if history.blank?

    messages = [
      { 'role' => 'system', 'content' => history['prompt'] }
    ]
    q_and_a.each do |question, answer|
      messages << { 'role' => 'user', 'content' => question }
      messages << { 'role' => 'assistant', 'content' => answer }
    end
    messages << { 'role' => 'user', 'content' => message } if messages.size > 1

    response_raw = client.chat(
      parameters: {
        model: 'gpt-3.5-turbo',
        messages:,
        temperature: 0.7,
        max_tokens: 500,
        top_p: 1,
        frequency_penalty: 0,
        presence_penalty: 0
      }
    )

    history['history'] << response_raw

    Rails.logger.debug response_raw
    response = JSON.parse(response_raw.to_json, object_class: OpenStruct)
    q_and_a << [message, response.choices[0].message.content]
  end

  private

  def client
    OpenAI::Client.new
  end
end
