{
  description = "Security tools development shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      nixpkgsSecurityTools =
        with pkgs;
        [
          # Networking
          nmap
          wireshark
          tshark
          netcat
          socat
          dnsenum

          # Wireless
          # aircrack-ng

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
        ]
        # Scripting Tools
        ++ (with pkgs.python3Packages; [
          requests
          beautifulsoup4
          pwntools
        ]);
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        name = "nixec";
        packages = nixpkgsSecurityTools;
        shellHook = ''
          echo -e "\e[32m󰒃 Security Environment Ready, Using nixos-25.05\e[0m"
        '';
      };
    };
}
