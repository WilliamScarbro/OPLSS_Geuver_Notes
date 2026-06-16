# OPLSS Geuver Notes

LaTeX notes for Herman Geuvers' Introduction to Type Theory lectures.

## Build

From the repository root:

```sh
./install.sh
```

To install TeX dependencies on a supported system before building:

```sh
./install.sh --install-deps
```

To remove generated LaTeX files before building:

```sh
./install.sh --clean
```

By default the script builds `Notes_Template_Geuvers.tex`. To build another entrypoint:

```sh
TEX_FILE=other-file.tex ./install.sh
```
