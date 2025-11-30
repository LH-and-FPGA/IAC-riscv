#!/bin/bash

# This script runs the testbench
# Usage: ./doit.sh <file1.cpp> <file2.cpp>

# Constants
SCRIPT_DIR=$(dirname "$(realpath "$0")")
TEST_FOLDER=$(realpath "$SCRIPT_DIR/tests")
RTL_FOLDER=$(realpath "$SCRIPT_DIR/../rtl")
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
RESET=$(tput sgr0)

# Variables
passes=0
fails=0

# Handle terminal arguments
if [[ $# -eq 0 ]]; then
    # No arguments: run every testbench in tb/tests
    # All tests except the debug_* helpers (they are noisy/interactive)
    mapfile -t files < <(find "${TEST_FOLDER}" -maxdepth 1 -name '*.cpp' ! -name 'debug_*.cpp' -print | sort)
else
    # If arguments provided, use them as input files
    files=("$@")
fi

cd $SCRIPT_DIR

# Wipe previous test output
rm -rf test_out/*
mkdir -p test_out

# Iterate through files
for file in "${files[@]}"; do
    base=$(basename "$file" .cpp)
    name=$(echo "$base" | sed 's/_tb$//' | cut -f1 -d\-)
    echo "${GREEN}Running $(basename "$file")${RESET}"

    # If verify.cpp or debug_*.cpp -> we are testing the top module
    if [[ "$name" == "verify" ]] || [[ "$name" == debug_* ]]; then
        name="top"
    fi

    # Translate Verilog -> C++ including testbench
    if [[ -f ${RTL_FOLDER}/${name}.sv ]]; then
        target_sv=${RTL_FOLDER}/${name}.sv
    elif [[ "${name}" == "lsu" && -f ${RTL_FOLDER}/lsu/lsu_top.sv ]]; then
        # LSU RTL lives under rtl/lsu/lsu_top.sv
        target_sv=${RTL_FOLDER}/lsu/lsu_top.sv
    elif [[ -f ${RTL_FOLDER}/cache/${name}.sv ]]; then
        target_sv=${RTL_FOLDER}/cache/${name}.sv
    elif [[ -f ${RTL_FOLDER}/fpu/${name}.sv ]]; then
        target_sv=${RTL_FOLDER}/fpu/${name}.sv
    elif [[ -f ${RTL_FOLDER}/ifu/${name}.sv ]]; then
        target_sv=${RTL_FOLDER}/ifu/${name}.sv
    elif [[ -f ${RTL_FOLDER}/lsu/${name}.sv ]]; then
        target_sv=${RTL_FOLDER}/lsu/${name}.sv
    else
        echo "Cannot find RTL for ${name}"
        exit 1
    fi

    declare -a extra_v_files=()
    for extra in cache/cache.sv cache/l1_cache.sv cache/l2_cache.sv cache/cacheway.sv cache/addr_decode.sv cache/lru.sv; do
        if [[ -f ${RTL_FOLDER}/${extra} ]]; then
            extra_v_files+=("-v" "${RTL_FOLDER}/${extra}")
        fi
    done

    if ! verilator  -Wall --trace --Wno-UNUSED \
                    -cc ${target_sv} \
                    --exe ${file} \
                    -y ${RTL_FOLDER} \
                    -y ${RTL_FOLDER}/cache \
                    -y ${RTL_FOLDER}/ieu \
                    -y ${RTL_FOLDER}/ifu \
                    -y ${RTL_FOLDER}/lsu \
                    -y ${RTL_FOLDER}/fpu \
                    -y ${RTL_FOLDER}/hazard \
                    "${extra_v_files[@]}" \
                    --prefix "Vdut" \
                    -o Vdut \
                    -LDFLAGS "-lgtest -lgtest_main -lpthread"; then
        echo "${RED}Verilator failed for ${name}${RESET}"
        ((fails++))
        continue
    fi

    # Build C++ project with automatically generated Makefile
    if ! make -j16 -C obj_dir/ -f Vdut.mk; then
        echo "${RED}Build failed for ${name}${RESET}"
        ((fails++))
        continue
    fi

    # Run executable simulation file
    if ./obj_dir/Vdut; then
        ((passes++))
    else
        ((fails++))
    fi

done

# Save obj_dir in test_out
if [[ -d obj_dir ]]; then
    mv obj_dir test_out/
fi

echo "${GREEN}Passes: ${passes}${RESET} | ${RED}Fails: ${fails}${RESET}"
if [[ $fails -ne 0 ]]; then
    exit 1
fi
