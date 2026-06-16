#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEX_FILE="${TEX_FILE:-Notes_Template_Geuvers.tex}"

usage() {
  cat <<'USAGE'
Usage: ./install.sh [--install-deps] [--clean]

Builds the LaTeX document in this repository.

Options:
  --install-deps  Install TeX build dependencies on supported systems.
  --clean         Remove generated LaTeX build files before building.

Environment:
  TEX_FILE        TeX entrypoint to build. Defaults to Notes_Template_Geuvers.tex.
USAGE
}

install_deps=false
clean=false

for arg in "$@"; do
  case "$arg" in
    --install-deps)
      install_deps=true
      ;;
    --clean)
      clean=true
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $arg" >&2
      usage >&2
      exit 2
      ;;
  esac
done

install_dependencies() {
  if command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y latexmk texlive-latex-base texlive-latex-recommended texlive-latex-extra
    return
  fi

  if command -v dnf >/dev/null 2>&1; then
    sudo dnf install -y latexmk texlive-scheme-medium texlive-blindtext texlive-fancyhdr texlive-geometry
    return
  fi

  if command -v brew >/dev/null 2>&1; then
    brew install --cask mactex-no-gui
    return
  fi

  cat >&2 <<'EOF'
No supported package manager was found.

Install a TeX distribution that includes latexmk, pdflatex, graphicx,
geometry, fancyhdr, babel, and blindtext, then run ./install.sh again.
EOF
  exit 1
}

require_command() {
  local command_name="$1"
  if ! command -v "$command_name" >/dev/null 2>&1; then
    cat >&2 <<EOF
Missing required command: $command_name

Run ./install.sh --install-deps on a supported system, or install a TeX
distribution manually and try again.
EOF
    exit 1
  fi
}

cd "$ROOT_DIR"

if "$install_deps"; then
  install_dependencies
fi

require_command latexmk
require_command pdflatex

if [[ ! -f "$TEX_FILE" ]]; then
  echo "TeX entrypoint not found: $TEX_FILE" >&2
  exit 1
fi

if "$clean"; then
  latexmk -C "$TEX_FILE"
fi

latexmk -pdf -interaction=nonstopmode -halt-on-error "$TEX_FILE"

PDF_FILE="${TEX_FILE%.tex}.pdf"
echo "Built $PDF_FILE"
