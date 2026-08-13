# CE3201 Digital Design CI Template

This repository contains a minimal digital design verification flow for a SystemVerilog adder, using Verilator and cocotb for the open-source validation path.

## Local verification

### Direct local run in Linux/WSL

```bash
make
```

### Docker-based local run

This repository includes a Dockerfile that installs the required toolchain, including Verilator and cocotb. You can run the project in a clean, reproducible environment without installing dependencies manually:

```bash
docker build -t ce3201 .
docker run --rm -it -v "$PWD:/work" -w /work ce3201 make
```

This mounts the workspace into the container and executes the same `make` target used by the repo.

## Repository structure

- `src/` contains the RTL source files.
- `tests/` contains the cocotb Python testbench.
- `quartus/` contains the native Quartus project files and the top-level design file.
- `output_files/` stores the canonical local synthesis report artifact used by the CI gate.
- `.github/workflows/` contains the repository gatekeeper workflow.

## Quartus flow

The Quartus project is defined in the `quartus/` directory and includes the project settings and the top-level module file.

The native Quartus synthesis/place-and-route flow should run on the Windows host where Quartus is installed. A post-flow Tcl script (`quartus/post_flow.tcl`, registered via `POST_FLOW_SCRIPT_FILE` in `adder_top.qsf`) runs automatically when "Compile Design" finishes and copies the generated report into `output_files/adder.flow.rpt` so that the repository gate can validate that the local compile succeeded — no manual copy step required.

## GitHub CI gate

The PR gate checks for the required artifact at:

```text
output_files/adder.flow.rpt
```

and verifies that the file contains `Successful`.

## How this repository is expected to work

This repository is intentionally split into two environments:

- Open-source verification flow: Linux/WSL2/DevContainer, using Verilator and cocotb.
- Native vendor flow: Windows host with Quartus installed for synthesis/place-and-route.

The Dockerfile in this repository is version-controlled and is the canonical way to reproduce the Linux verification environment locally. It installs the toolchain needed to compile and run the testbench, including Verilator and cocotb. Students should use this environment for the repository’s open-source verification path.

Quartus is not expected to run inside Docker or GitHub Actions. It is a native Windows-hosted EDA tool and should be used on the machine where Quartus is installed. The `quartus/post_flow.tcl` script copies the generated Quartus report into `output_files/adder.flow.rpt` automatically so the repository gate can validate the compile result.

## Notes

- The repository source is tracked in Git.
- Generated build output and tool caches are expected to be ignored or cleaned.
- The Docker recipe is part of the project definition and is therefore kept under version control.
- Local validation should be done with `make` either directly on Linux/WSL or via the Docker recipe above.
