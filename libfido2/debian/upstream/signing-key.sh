#!/usr/bin/env bash
set -euo pipefail

# List from https://developers.yubico.com/Software_Projects/Software_Signing.html
KEYS=(
	0A3B0262BCA1705307D5FF06BCA00FD4B2168C0A # Klas Lindfors <klas@yubico.com>
	20EE325B86A81BCBD3E56798F04367096FBA95E8 # Dain Nilsson <dain@yubico.com>
	B70D62AA6A31AD6B9E4F9F4BDC8888925D25CA7A # Alessio Di Mauro <alessio@yubico.com>
	FF8AF719AE5828181B894D831CE39268A0973948 # Tommaso De Orchi <tom@yubico.com>
	B6042E2BD1FDBC2BCA8588B2FF8D3B45B7B875A9 # Jean Paul Galea <jeanpaul@yubico.com>
	8D0B4EBA9345254BCEC0E843514F078FF4AB24C3 # Dag Heyman <dag@yubico.com>
	57A9DEED4C6D962A923BB691816F3ED99921835E # Emil Lundberg <emil@yubico.com>
	268583B64786F50F807456DA8CED3A80D41C0DCB # Trevor Bentley <trevor@yubico.com>
	1D7308B0055F5AEF36944A8F27A9C24D9588EA0F # Aveen Ismail <aveen.ismail@yubico.com>
	355C8C0186CC96CBA49F9CD8DAA17C2953914D9D # Alessandro Carlo Chirico <alessandro.chirico@yubico.com>
	9E885C0302F9BB9167529C2D5CBA11E6ADC7BCD1 # Dennis Fokin <dennis.fokin@yubico.com>
	7FBB6186957496D58C751AC20E777DD85755AA4A # Konstantinos Georgantas <kostas@yubico.com>
)

if [ $# -gt 0 ]; then
	exec gpg "$@" "${KEYS[@]}"
else
	exec gpg --export --export-options export-minimal -a --yes \
		-o "$(dirname "$0")/signing-key.asc" "${KEYS[@]}"
fi
