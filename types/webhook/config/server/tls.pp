type R10k::Webhook::Config::Server::Tls = Struct[{
    enabled     => Boolean,
    certificate => Optional[Stdlib::Absolutepath],
    key         => Optional[Stdlib::Absolutepath],
}]
