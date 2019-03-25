defmodule Football.Results.ProtobufMsgs do
  @moduledoc """
  Module for holding Protocol Buffer Messages.

  This is reading the a `result.proto` file that contains the message definition.
  It is another representation of `Football.Results.Result`.

  It is used as a intermediary format to be encoded by `Protobuf` package.
  """
  use Protobuf, from: Path.expand("result.proto", __DIR__)
end
