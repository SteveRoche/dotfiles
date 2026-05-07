{ ... }:
{
  flake.homeModules.gpg =
    { ... }:
    {
      programs.gpg.enable = true;
      services.gpg-agent.enable = true;
    };
}
