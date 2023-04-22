defmodule OneClickCampaign.AI do
  @moduledoc """
  The GPT context.
  """

  require Logger

  @spec prompt(String.t()) :: String.t()
  def prompt(message) do
    with {:ok,
          %ExOpenAI.Components.CreateChatCompletionResponse{
            choices: [%{message: %{content: content}} | _]
          }} <-
           service().create_chat_completion(
             [%{role: "user", content: message}],
             "gpt-3.5-turbo",
             logit_bias: %{
               "8043" => -100
             }
           ) do
      Logger.info("""
      Asking:
      =====
      #{message}
      Answered
      =====
      #{content}
      """)

      content
    end
  end

  # used to create fake responses similar to ExOpenAPI
  def create_chat_completion(_msgs, _model, _opts) do
    {:ok,
     %ExOpenAI.Components.CreateChatCompletionResponse{
       choices: [%{message: %{content: "EXAMPLE AI GENERATED CONTENT"}}],
       created: nil,
       model: nil,
       id: nil,
       object: nil
     }}
  end

  defp service() do
    # swap __MODULE__ to ExOpenAI.Chat to test against the real API.
    Application.get_env(:one_click_campaign, :ai_chat_service, __MODULE__)
  end
end
