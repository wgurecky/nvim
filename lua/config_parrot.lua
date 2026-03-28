-- Websearch tool definition
local websearch_tool = {
  name = "web_search",
  type = "web_search_20260209",
  max_uses = 3,
}

--- AI parrot.nvim Settings
require("parrot").setup {
  -- Providers must be explicitly set up to make them available.
  providers = {
      anthropic = {
        name = "anthropic",
        endpoint = "https://api.anthropic.com/v1/messages",
        model_endpoint = "https://api.anthropic.com/v1/models",
        -- set in bashrc export ANTHROPIC_API_KEY="<key>"
        api_key = os.getenv("ANTHROPIC_API_KEY"),
        params = {
          chat = { max_tokens = 8096 },
          command = { max_tokens = 8096 },
        },
        --- topic model used for summaries
        topic = {
          model = "claude-haiku-4-5",
          params = { max_tokens = 128 },
        },
        headers = function(self)
          return {
            ["Content-Type"] = "application/json",
            ["x-api-key"] = self.api_key,
            ["anthropic-version"] = "2023-06-01",
          }
        end,
        --- main model used for chat and code suggestions
        models = {
          "claude-sonnet-4-6",
          "claude-haiku-4-5",
        },
        preprocess_payload = function(payload)
          for _, message in ipairs(payload.messages) do
            message.content = message.content:gsub("^%s*(.-)%s*$", "%1")
          end
          if payload.messages[1] and payload.messages[1].role == "system" then
            -- remove the first message that serves as the system prompt as anthropic
            -- expects the system prompt to be part of the API call body and not the messages
            payload.system = payload.messages[1].content
            table.remove(payload.messages, 1)
          end
          --- adds websearch tool if the websearch string is found in message
          local last_message = payload.messages[#payload.messages]
          if last_message and type(last_message.content) == "string" and last_message.content:lower():find("websearch") then
            payload.tools = { websearch_tool }
          else
            payload.tools = { }
          end
          return payload
        end,
    },
  },
}
--           local last_message = payload.messages[#payload.messages]
--           if last_message and type(last_message.content) == "string" and last_message.content:lower():find("websearch") then
--             payload.tools = { websearch_tool }
--           end

--           local last_message = payload.messages[#payload.messages][1]
--           if type(last_message.content) == "string" and last_message.content:lower():find("websearch") then
--             has_websearch = true
--             break
--           end
--
--           local has_websearch = false
--           for _, message in ipairs(payload.messages) do
--             if type(message.content) == "string" and message.content:lower():find("websearch") then
--               has_websearch = true
--               break
--             end
--           end
--           if has_websearch then
--             payload.tools = { websearch_tool }
--           end
