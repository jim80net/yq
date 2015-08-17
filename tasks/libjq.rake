desc("Install the libjq library, required for ruby-jq")
task(:libjq_install) do
  code=<<-EOF
    git clone https://github.com/stedolan/jq.git
    cd jq
    autoreconf -i
    ./configure --enable-shared --disable-maintainer-mode
    make
    sudo make install
  EOF
  `#{code}`
end



