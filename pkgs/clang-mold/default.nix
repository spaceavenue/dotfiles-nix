{ lib, runCommand, llvmPackages, mold }:

runCommand "clang-mold-${llvmPackages.clang.version}"
{
  meta = with lib; {
    description = "clang with mold as default linker";
    mainProgram = "clang";
    platforms = platforms.linux;
  };
}
''
  mkdir -p $out/bin
  for name in clang clang++; do
    ln -s ${llvmPackages.clang}/bin/$name $out/bin/$name-real
    cat > $out/bin/$name <<EOF
#!/bin/sh
exec $out/bin/$name-real -fuse-ld=${mold}/bin/mold -Wno-unused-command-line-argument "\$@"
EOF
    chmod +x $out/bin/$name
  done
  ln -s clang $out/bin/cc
  ln -s clang++ $out/bin/c++
''
