#! /usr/bin/env bash
set -eu
shopt -s nullglob

# Locate the script file.  Cross symlinks if necessary.
loc="$0"
while [ -h "$loc" ]; do
    ls=`ls -ld "$loc"`
    link=`expr "$ls" : '.*-> \(.*\)$'`
    if expr "$link" : '/.*' > /dev/null; then
        loc="$link"  # Absolute link
    else
        loc="`dirname "$loc"`/$link"  # Relative link
    fi
done
base_dir=$(cd "`dirname "$loc"`" && pwd)

temp_out="$base_dir/djinni-output-temp"

in1="$base_dir/KeyValueRepository.djinni"
in2="$base_dir/Services.djinni"

yaml_out="$base_dir/generated-src/yaml"
cpp_out="$base_dir/generated-src/cpp"
jni_out="$base_dir/generated-src/jni"
objc_out="$base_dir/generated-src/objc"
java_out="$base_dir/generated-src/java/com/dropbox/textsort"

java_package="com.dropbox.textsort"

gen_stamp="$temp_out/gen.stamp"

if [ $# -eq 0 ]; then
    # Normal build.
    true
elif [ $# -eq 1 ]; then
    command="$1"; shift
    if [ "$command" != "clean" ]; then
        echo "Unexpected argument: \"$command\"." 1>&2
        exit 1
    fi
    for dir in "$temp_out" "$cpp_out" "$jni_out" "$java_out"; do
        if [ -e "$dir" ]; then
            echo "Deleting \"$dir\"..."
            rm -r "$dir"
        fi
    done
    exit
fi

# Build djinni
"$base_dir/../src/build"

[ ! -e "$temp_out" ] || rm -r "$temp_out"
"$base_dir/../src/run-assume-built" \
    --yaml-out "$temp_out/yaml"\
    --yaml-out-file "KeyValueRepository.yaml"\
    \
    --cpp-out "$temp_out/cpp" \
    --cpp-namespace textsort \
    --ident-cpp-enum-type foo_bar \
    --cpp-nn-header "\"$base_dir/include/nn/nn.hpp\"" \
    --cpp-nn-type "dropbox::oxygen::nn_shared_ptr" \
    --cpp-nn-check-expression "NN_CHECK_ASSERT" \
    \
    --objc-out "$temp_out/objc" \
    --objcpp-out "$temp_out/objc" \
    --objc-type-prefix TXS \
    --objc-swift-bridging-header "TextSort-Bridging-Header" \
    \
    --idl "$in1"

"$base_dir/../src/run-assume-built" \
    --yaml-out "$temp_out/yaml"\
    --yaml-out-file "Configuration.yaml"\
    --idl-include-path "$temp_out/yaml"\
    \
    --cpp-out "$temp_out/cpp" \
    --cpp-namespace textsort \
    --ident-cpp-enum-type foo_bar \
    --cpp-nn-header "\"$base_dir/include/nn/nn.hpp\"" \
    --cpp-nn-type "dropbox::oxygen::nn_shared_ptr" \
    --cpp-nn-check-expression "NN_CHECK_ASSERT" \
    \
    --objc-out "$temp_out/objc" \
    --objcpp-out "$temp_out/objc" \
    --objc-type-prefix TXS \
    --objc-swift-bridging-header "TextSort-Bridging-Header" \
    \
    --idl "$in2"

# Copy changes from "$temp_output" to final dir.

mirror() {
    local prefix="$1" ; shift
    local src="$1" ; shift
    local dest="$1" ; shift
    mkdir -p "$dest"
    rsync -r --delete --checksum --itemize-changes "$src"/ "$dest" | sed "s/^/[$prefix]/"
}

echo "Copying generated code to final directories..."
mirror "yaml" "$temp_out/yaml" "$yaml_out"
mirror "cpp" "$temp_out/cpp" "$cpp_out"
mirror "java" "$temp_out/java" "$java_out"
mirror "jni" "$temp_out/jni" "$jni_out"
mirror "objc" "$temp_out/objc" "$objc_out"

date > "$gen_stamp"

echo "djinni completed."
