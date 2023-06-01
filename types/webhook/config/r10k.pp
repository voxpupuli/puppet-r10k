type R10k::Webhook::Config::R10k = Struct[{
    command_path    => Optional[Stdlib::Absolutepath],
    config_path     => Optional[Stdlib::Absolutepath],
    default_branch  => Optional[String[1]],
    prefix          => Optional[String[1]],
    allow_uppercase => Optional[Boolean],
    verbose         => Optional[Boolean],
    deploy_modules  => Optional[Boolean],
    generate_types  => Optional[Boolean],
}]
