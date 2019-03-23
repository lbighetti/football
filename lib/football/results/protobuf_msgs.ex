defmodule Football.Results.ProtobufMsgs do
  use Protobuf, from: Path.expand("result.proto", __DIR__)
end
