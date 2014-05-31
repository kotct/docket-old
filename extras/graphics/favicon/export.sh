#!/bin/sh

if type inkscape &> /dev/null;
then
	printf "Inkscape acquired.\n"
else
	printf "I require Inkscape, however it does not appear to be installed.\n"
	printf "Please install Inkscape before trying to export this SVG file.\n"

	exit 1
fi

svg="favicon.svg"
output_prefix="favicon"
output_delim="_"

export_resolutions=( 24 32 64 128 256 512 768 1024 )

printf "I will export at resolutions: %s\n" "${export_resolutions[*]}"

for i in ${export_resolutions[@]};
do
	output_filename="$output_prefix$output_delim$i.png"

	printf "Exporting at resolution: %s to %s\n" "$i" "$output_filename"

	inkscape --export-png=$output_filename --export-width=$i --export-height=$i favicon.svg
done
