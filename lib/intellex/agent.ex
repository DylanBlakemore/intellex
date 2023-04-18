defmodule Intellex.Agent do
  defstruct [:uuid, :chain, :toolkit, :system, :prompt]

  alias Intellex.{Action, Chain, LLM, Message, Parser}

  @type t :: %__MODULE__{}

  @spec new(keyword()) :: {:ok, %__MODULE__{}}
  def new(opts) do
    {:ok,
     %__MODULE__{
       uuid: opts[:uuid] || generate_uuid(),
       chain: init_chain(opts),
       system: opts[:system],
       prompt: opts[:prompt],
       toolkit: opts[:toolkit]
     }}
  end

  defp init_chain(opts) do
    Chain.new!()
    |> Chain.link(Message.system(opts[:system]))
    |> Chain.link(Message.user(opts[:prompt]))
  end

  defp generate_uuid do
    :crypto.strong_rand_bytes(16)
    |> Base.encode16(case: :lower)
  end

  @spec link(t(), Message.t()) :: t()
  defp link(agent, message) do
    %__MODULE__{agent | chain: Chain.link(agent.chain, message)}
  end

  @spec run(t()) :: {atom(), String.t()}
  def run(agent) do
    with {:ok, response} <- chat(agent) do
      agent
      |> link(response.message)
      |> respond()
    else
      {:error, error} -> {:error, error}
    end
  end

  defp respond(agent) do
    message = List.last(agent.chain.messages)

    case Parser.parse_status(message.content) do
      {:ok, "Incomplete"} -> handle_action(agent, message)
      {:ok, "Complete"} -> {:ok, message}
      {:ok, "Failed"} -> {:error, message}
      {:ok, status} -> handle_error(agent, "Unknown status: #{status}")
      {:error, _} -> handle_error(agent, "Unknown response format")
    end
  end

  defp handle_error(agent, error) do
    agent
    |> link(Message.user(error))
    |> run()
  end

  defp handle_action(agent, message) do
    {_, result} =
      message.content
      |> Action.new!()
      |> Action.run(agent.toolkit)

    agent
    |> link(result)
    |> run()
  end

  defp chat(agent) do
    LLM.chat(agent.chain)
  end
end
