{ ... }:
{
  flake.nixosModules.ssh = { pkgs, ... }: {
    programs.ssh.startAgent = true;
    services.gnome.gcr-ssh-agent.enable = false;
  };
}
