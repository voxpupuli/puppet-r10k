# @summary webhook config chatops type
type R10k::Webhook::Config::Chatops = Struct[
  {
    enabled    => Boolean,
    service    => Optional[Enum['slack', 'rocketchat']],
    channel    => Optional[String[1]],
    user       => Optional[String[1]],
    auth_token => Optional[String[1]],
    server_uri => Optional[String[1]],
  }
]
