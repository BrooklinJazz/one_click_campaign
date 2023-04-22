defmodule OneClickCampaign.AITest do
  use ExUnit.Case, async: false
  doctest OneClickCampaign.AI
  alias OneClickCampaign.AI

  import Mock

  setup_all do
    Application.put_env(:one_click_campaign, :ai_chat_service, ExOpenAI.Chat)
    on_exit(fn -> Application.put_env(:one_click_campaign, :ai_chat_service, AI) end)
  end

  test "prompt/1" do
    with_mock ExOpenAI.Chat,
      create_chat_completion: fn _msgs, _model, _bias ->
        {:ok,
         %ExOpenAI.Components.CreateChatCompletionResponse{
           choices: [
             %{
               finish_reason: "stop",
               index: 0,
               message: %{
                 content: "example answer",
                 role: "assistant"
               }
             }
           ],
           created: 1_682_201_653,
           id: "chatcmpl-78FmfMKTYPtZq9YP6IeZaTddJ7XTY",
           model: "gpt-3.5-turbo-0301",
           object: "chat.completion",
           usage: %{completion_tokens: 353, prompt_tokens: 41, total_tokens: 394}
         }}
      end do
      assert AI.prompt("example question") == "example answer"

      assert_called(
        ExOpenAI.Chat.create_chat_completion(
          [%{role: "user", content: "example question"}],
          "gpt-3.5-turbo",
          logit_bias: %{
            "8043" => -100
          }
        )
      )
    end
  end
end
