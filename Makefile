all:
	python3 scripts/html_to_motoko.py -s html -d src/spaceboots/frontend
	dfx deploy spaceboots

generate_code:
	python3 scripts/generator.py -k 00000000000000000000000000000000 -u 047423A2E51090 -c 33333 -d src/spaceboots/cmac.mo
