require 'openai'

class GptService
  def initialize(prompt)
    @prompt = extract_plain_text(prompt)
    @client = OpenAI::Client.new(access_token: Rails.application.credentials.dig(:openai, :api_key), log_errors: true)
  end

  def generate_content
    response = @client.chat(
      parameters: {
        model: "gpt-4",  # Use the appropriate model name
        messages: [
          { role: "user", content: @prompt }
        ],
        max_tokens: 150
      }
    )
    response.dig('choices', 0, 'message', 'content').strip
  end

  # Convert rich text to plain text
  def extract_plain_text(rich_text)
    ActionText::Content.new(rich_text).to_plain_text
  end

end
