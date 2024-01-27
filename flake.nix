{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";

    insanely_fast_whisper_src.url = "github:Vaibhavs10/insanely-fast-whisper";
    insanely_fast_whisper_src.flake = false;
  };

  outputs = { self, nixpkgs, flake-utils,
              insanely_fast_whisper_src
            }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        pythonPackages = pkgs.python311Packages;
      in {
        packages = rec {
          default = insanely-fast-whisper;

          pyscaffold = pythonPackages.buildPythonPackage rec {
            pname = "pyscaffold";
            version = "3.2";
            format = "pyproject";
            src = pythonPackages.fetchPypi {
              pname = "PyScaffold";
              inherit version;
              sha256 = "sha256-VUJ3NcrVCepB/IpimNGkkP8ZEI3b0Nu+40bG41Jn3do=";
            };
            nativeBuildInputs = [
              pythonPackages.setuptools-scm
            ];
          };

          pyannote-audio = pythonPackages.buildPythonPackage rec {
            pname = "pyannote-audio";
            version = "3.1.0";
            format = "pyproject";
            src = pythonPackages.fetchPypi {
              pname = "pyannote.audio";
              inherit version;
              sha256 = "sha256-2gRwVEPTt0YH4DTTyoj4tXLH6Wct2aQZnKtloNvDP60=";
            };

            nativeBuildInputs = [
              pythonPackages.setuptools-scm
            ];

            propagatedBuildInputs = [
              pythonPackages.semver
              pythonPackages.optuna

              pyscaffold
              pyannote-pipeline
            ];
          };

          pyannote-pipeline = pythonPackages.buildPythonPackage rec {
            pname = "pyannote-pipeline";
            version = "3.0.1";
            format = "pyproject";
            src = pythonPackages.fetchPypi {
              pname = "pyannote.pipeline";
              inherit version;
              sha256 = "sha256-AheU4mos9dj7W7GDWVHnH1+sM+sU4j37dGjhaxuAUVE=";
            };

            nativeBuildInputs = [
              pythonPackages.setuptools-scm
            ];

            propagatedBuildInputs = [
            ];
          };

          pyannote-core = pythonPackages.buildPythonPackage rec {
            pname = "pyannote-core";
            version = "5.0.0";
            format = "pyproject";
            src = pythonPackages.fetchPypi {
              pname = "pyannote.core";
              inherit version;
              sha256 = "sha256-GlW8yL1oC6a+X6U++jtvPSzdZxRMB7a02NZtXLDSCW8=";
            };

            nativeBuildInputs = [
              pythonPackages.setuptools-scm
            ];

            propagatedBuildInputs = [
              torch-audiomentations
            ];
          };

          pyannote-database = pythonPackages.buildPythonPackage rec {
            pname = "pyannote-database";
            version = "5.0.1";
            format = "pyproject";
            src = pythonPackages.fetchPypi {
              pname = "pyannote.database";
              inherit version;
              sha256 = "sha256-mAvckQYVOAoX2L2CgF+XcABtBQssepRqUgreRicZJoE=";
            };

            nativeBuildInputs = [
              pythonPackages.setuptools-scm
            ];

            propagatedBuildInputs = [
              pythonPackages.pandas
            ];
          };

          torch-audiomentations = pythonPackages.buildPythonPackage rec {
            pname = "torch-audiomentations";
            version = "0.11.0";
            format = "pyproject";
            src = pythonPackages.fetchPypi {
              inherit pname version;
              sha256 = "sha256-AX6Otau5hh/2ZyfKKserKMGbsNMQ0ogguKmA6Z02VXo=";
            };

            nativeBuildInputs = [
              pythonPackages.setuptools-scm
            ];

            propagatedBuildInputs = [
              pythonPackages.librosa
              julius
              torch-pitch-shift
            ];
          };

          torch-pitch-shift =  pythonPackages.buildPythonPackage rec {
            pname = "torch-pitch-shift";
            version = "1.2.4";
            format = "pyproject";
            src = pythonPackages.fetchPypi {
              pname = "torch_pitch_shift";
              inherit version;
              sha256 = "sha256-wXP8gIGEpoTB7NmdV0RXPlWmZ/I44iaK2vFclGfZnbk=";
            };

            nativeBuildInputs = [
              pythonPackages.setuptools-scm
            ];

            propagatedBuildInputs = [
              primePy
            ];
          };

          primePy =  pythonPackages.buildPythonPackage rec {
            pname = "primePy";
            version = "1.3";
            format = "pyproject";
            src = pythonPackages.fetchPypi {
              inherit pname version;
              sha256 = "sha256-Jf1+JTRLB4mlmEx12J8FT88fGAvvIMmY5L77rJLeRmk=";
            };

            nativeBuildInputs = [
              pythonPackages.setuptools-scm
            ];

            propagatedBuildInputs = [
            ];
          };

          julius = pythonPackages.buildPythonPackage rec {
            pname = "julius";
            version = "0.2.7";
            format = "pyproject";
            src = pythonPackages.fetchPypi {
              inherit pname version;
              sha256 = "sha256-PA9fUwbX1gFvzJUZaydMrm8H4slZbu0xTk52QVVPuwg=";
            };

            nativeBuildInputs = [
              pythonPackages.setuptools-scm
            ];

            propagatedBuildInputs = [
              # pythonPackages.librosa

            ];
          };


          insanely-fast-whisper = pythonPackages.buildPythonPackage rec {
            pname = "insanely-fast-whisper";
            version = "0.0.13";
            format = "pyproject";
            src = pythonPackages.fetchPypi {
              pname = "insanely_fast_whisper";
              inherit version;
              sha256 = "sha256-01AIxRy5DDnNgalmIx7Y54T5KBibakGimB62GGFo2Rc=";
            };

            nativeBuildInputs = [
              pythonPackages.setuptools-scm
              pythonPackages.pdm-backend
            ];

            buildInputs = with pkgs; [
              pdm
            ];

            propagatedBuildInputs = [
              pythonPackages.transformers
              pythonPackages.rich
              pythonPackages.torch
              pythonPackages.torchaudio
              pythonPackages.pytorch-lightning
              pythonPackages.soundfile
              pythonPackages.scipy
              pythonPackages.einops
              pythonPackages.sortedcontainers

              pyannote-audio
              pyannote-core
              pyannote-database
            ];
          };
        };
      }
    );
}
