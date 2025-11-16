{ pkgs, user, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user.username} = {
    isNormalUser = true;
    description = "${user.fullName}";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
  };
}
