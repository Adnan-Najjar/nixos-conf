{
  description = "Security tools development shell";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      packages =
        with pkgs;
        [
          # Networking
          nmap
          wireshark
          tshark
          netcat
          socat
          dnsenum

          # Password cracking
          hashcat
          john

          # Exploitation
          metasploit

          # Reverse Engineering
          radare2

          # Forensics
          binwalk
          volatility3

          # Utility
          curl
          wget

          openvpn
        ]
        ++ (with pkgs.python3Packages; [
          requests
          beautifulsoup4
          pwntools
        ]);

      mkShellWithProxy =
        name: proxy:
        pkgs.mkShell {
          inherit name;
          inherit packages;
          shellHook = ''
            export http_proxy="${proxy}"
            export https_proxy="${proxy}"
            export HTTP_PROXY="${proxy}"
            export HTTPS_PROXY="${proxy}"
            export all_proxy="${proxy}"

            alias chrome="chromium --proxy-server=\"${proxy}\""
          '';
        };
    in
    {
      devShells.${system} = {
        default = mkShellWithProxy "nixec" "";

        # Provide any proxy
        proxy = mkShellWithProxy "nixec#proxy" "http://182.253.166.249:5678";

        offline = mkShellWithProxy "nixec#offline" "http://127.0.0.1:1";
      };
    };
}
