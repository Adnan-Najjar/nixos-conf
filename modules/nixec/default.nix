{ ... }:
{
  nix.registry = {
    nixec = {
      from = {
        type = "indirect";
        id = "nixec";
      };
      to = {
        type = "path";
        path = ./.;
      };
    };
  };
}
