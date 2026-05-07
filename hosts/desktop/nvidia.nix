{ inputs, self, ... }:
{
  flake.nixosModules.nvidia =
    { config, pkgs, ... }:
    {
      hardware.nvidia = {
        modesetting.enable = true;
        open = true;
        nvidiaSettings = true;
        powerManagement.enable = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
      };

      services.xserver.videoDrivers = [ "nvidia" ];

      environment.systemPackages = with pkgs; [ nvtopPackages.nvidia ];

      systemd = {
        # Fix for suspend/resume with Nvidia drivers https://discourse.nixos.org/t/suspend-resume-cycling-on-system-resume/32322/11
        services."gnome-suspend" = {
          description = "suspend gnome shell";
          before = [
            "systemd-suspend.service"
            "systemd-hibernate.service"
            "nvidia-suspend.service"
            "nvidia-hibernate.service"
          ];
          wantedBy = [
            "systemd-suspend.service"
            "systemd-hibernate.service"
          ];
          serviceConfig = {
            Type = "oneshot";
            ExecStart = "${pkgs.procps}/bin/pkill -f -STOP ${pkgs.gnome-shell}/bin/gnome-shell";
          };
        };
        services."gnome-resume" = {
          description = "resume-gnome-shell";
          after = [
            "systemd-suspend.service"
            "systemd-hibernate.service"
            "nvidia-resume.service"
          ];
          wantedBy = [
            "systemd-suspend.service"
            "systemd-hibernate.service"
          ];
          serviceConfig = {
            Type = "oneshot";
            ExecStart = "${pkgs.procps}/bin/pkill -f -CONT ${pkgs.gnome-shell}/bin/gnome-shell";
          };
        };
      };
    };
}
