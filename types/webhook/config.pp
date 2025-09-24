# @summary webhook config type
type R10k::Webhook::Config = Struct[
  {
    server  => Optional[R10k::Webhook::Config::Server],
    chatops => Optional[R10k::Webhook::Config::Chatops],
    r10k    => Optional[R10k::Webhook::Config::R10k],
  }
]
