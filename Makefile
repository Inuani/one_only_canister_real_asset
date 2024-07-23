all:
	python3 scripts/html_to_motoko.py -s html -d src/spaceboots/frontend
	dfx deploy spaceboots --ic

generate:
	python3 scripts/generator.py -k 00000000000000000000000000000000 -u 04A355C2E51090 -c 10000 -d src/spaceboots/cmac.mo
