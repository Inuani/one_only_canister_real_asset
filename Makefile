all:
	python3 scripts/html_to_motoko.py -s html -d src/spaceboots/frontend
	dfx deploy spaceboots --ic


generate:
	python3 scripts/generator.py -k 00000000000000000000000000000000 -u 042054E2E51090 -c 10000 -d src/spaceboots/cmac.mo


# --with-cycles 1000000000000

# install mops if necessary
#	curl -fsSL cli.mops.one/install.sh | sh
#	mops init