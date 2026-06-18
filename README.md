# OPLSS Geuver Notes

LaTeX notes for Herman Geuvers' Introduction to Type Theory lectures.

## Build

From the repository root:

```sh
./install.sh
```

To install TeX dependencies on a supported system (does not build):

```sh
./install.sh --install-deps
```

To remove generated LaTeX files before building:

```sh
./install.sh --clean
```

By default the script builds `Notes_Geuvers.tex`. To build another entrypoint:

```sh
TEX_FILE=other-file.tex ./install.sh
```

## Build with Docker

If you'd rather not install TeX Live locally, build inside a container.
The image bakes the PDF in at build time:

```sh
docker build -t oplss-geuver .
```

To copy the resulting PDF out of the image:

```sh
docker run --rm -v "$PWD:/out" oplss-geuver cp Notes_Geuvers.pdf /out/
```

Or, to rebuild against your local sources without rebuilding the image:

```sh
docker run --rm -v "$PWD:/workspace" oplss-geuver
```
