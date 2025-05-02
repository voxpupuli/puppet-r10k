# @summary webhook config server type
type R10k::Webhook::Config::Server = Struct[{
    protected => Boolean,
    user      => Optional[String[1]],
    password  => Optional[String[1]],
    port      => Optional[Stdlib::Port],
    tls       => Optional[R10k::Webhook::Config::Server::Tls],
    queue     => Optional[R10k::Webhook::Config::Server::Queue],
}]
